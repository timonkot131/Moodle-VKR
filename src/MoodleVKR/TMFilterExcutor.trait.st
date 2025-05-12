Trait {
	#name : #TMFilterExcutor,
	#category : #'MoodleVKR-Database'
}

{ #category : #converting }
TMFilterExcutor >> asSearchFilter [
^self
]

{ #category : #'as yet unclassified' }
TMFilterExcutor >> conjForEntity: anEntityClass [
| items |
items := (self forEntity: anEntityClass).
items ifEmpty: [
	^#pass
].
^items reduce: [:x :y | x & y]
]

{ #category : #execution }
TMFilterExcutor >> execute: aQueryCancellation [
| res stream chunks readStream query | 
			query := self conjForEntity: QueryRoot.
			GtJustContextStackSignal new emit.
			[res := (MoodleDBEventLog storedInstances sortBlock: [:p1 :p2 | 
				p1 timecreated > p2 timecreated
			]) satisfying: query] on: Error
			 do: [:anError | aQueryCancellation cancel: anError. 
			 	^ {} asAsyncStream
			 ].
			readStream := res readStream.
			aQueryCancellation weak 
				when: MoodleCancelEvent
				send: #close
				to: readStream.
			stream := IteratorStream forPosStream: readStream.
			chunks := (stream asAsyncStream chunks: 5) cached  collect: [:logs | 
				|userids courseids courseJob userJob users courses apiUser apiCourse|
				apiUser := ApiUser forToken: MConfig token.
				apiCourse := ApiCourse forToken:  MConfig token.
				userids := (logs collect: #userid) asSet. 
				courseids := (logs collect: #courseid) asSet reject: #isZero.
				userJob := (apiUser completeUsersChunk: userids) 
					inject: Dictionary new into: [:dic :user | dic at: user id put: user; yourself].
				courseJob := (apiCourse completeCoursesChunk: courseids) 
					inject: Dictionary new into: [:dic :course | dic at: course id put: course; yourself]. .
				courses := courseJob wait.
				courses ifNil: [courses := Dictionary new].
				users := userJob wait.
				apiUser close.
				apiCourse close.
				logs asAsyncStream collect: [:log  |
					MoodleEventLog new
						ip: log ip;
						contextLevel: log contextlevel;
						timeCreated: log timecreated;
						user: (users at: log userid ifAbsent: 
							[MoodleUser new fullName: 'nilUser'; email: 'nomail@example.com']);
						course: (courses at: log courseid ifAbsent: [nil]);
						eventName: log eventname;
						id: log id
				] 
			].
			^chunks flatten on: Error do: [:anError | 
				aQueryCancellation cancel: anError.
			    nil .
				]
]

{ #category : #query }
TMFilterExcutor >> forEntity: anEntityClass [
^self withDeep: #children select: 
	[:x | (x isKindOf: MethodSearchFilter) and: [x entity = anEntityClass] ] collect: #value
]

{ #category : #query }
TMFilterExcutor >> forEntity: anEntityClass attribute: aSymbol [
| items |
items := ((self forEntity: anEntityClass) select: [:x | x attribute = aSymbol] thenCollect: #selectedValue).
"Требуется логическое И над элементами множества. Имеется ввиду, что идет сбор"
"По одному аттрибуту"
"Если в будет множество с И с разными элементами и уникальными аттрибутам, то запрос никогда не пройдет"
(items size > 1) ifTrue: [
	^{}
].
items ifEmpty: [
	^#pass
].
^items asArray.
]

{ #category : #'as yet unclassified' }
TMFilterExcutor >> gtDistributedFor: aView [
	<gtToolView>
	<gtView>
	^ aView forward
		title: 'Distributed';
		priority: 7;
		object: [ self distributeAsync ];
		view: #gtLiveFor:
]

{ #category : #view }
TMFilterExcutor >> gtFilterQueryFor: aView [
<gtToolView>
<gtView>
^aView columnedList
		title: 'Items';
		priority: 5;
		items: [ ((ApiQueryBuilder new token: MConfig token) execute: self) asyncSimilarCopy.
		
		]; 
	 	column: 'index' text: [:each :index | index asString]; 
	 	 	column: 'id' text: [:each :_ | each id asString] width: 60; 
		column: 'Событие' text: [:each | each eventName]; 
		column: 'Пользователь' text: [:each | each user userName] width: 70;
		column: 'Курс' text: [ :each | each course ifNotNil: [:x | x shortname] ifNil: ['Нет'] ] width: 70;
		column: 'Дата' text: [ :each | MLogDate ofUnixToString: each timeCreated] width: 60;
		column: 'Время' text: [ :each | MLogTime ofUnixToString: each timeCreated] width: 50;
			
		actionUpdateButton
]

{ #category : #'as yet unclassified' }
TMFilterExcutor >> gtItemsFor: aView [
	"this is a view that is polymorphic with the one defined in ${method:Collection>>#gtItemsFor:}$"
	<gtView>
	<gtToolView>

	^ aView forward
		title: 'Results';
		priority: 10;
		object: [ self ];
		view: #gtHierarchyFor:
]

{ #category : #view }
TMFilterExcutor >> gtPreloaded: aView [
<gtToolView>
<gtView>
^ aView columnedList
		title: 'Preloaded';
		priority: 6;
		items: [ ((ApiQueryBuilder new token: MConfig token) preloaded: self) asyncSimilarCopy.];
		column: 'Number' text: [ :_ :anIndex | anIndex ] width: 50;
		column: 'Name' text: [ :each | each ];
		actionUpdateButton

]

{ #category : #testing }
TMFilterExcutor >> isEmpty [
^false
]
