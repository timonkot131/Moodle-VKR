Class {
	#name : #ApiQueryBuilder,
	#superclass : #Object,
	#traits : 'TMQueryBuilder',
	#classTraits : 'TMQueryBuilder classTrait',
	#instVars : [
		'query',
		'token',
		'cancellation'
	],
	#category : #'MoodleVKR-API'
}

{ #category : #converting }
ApiQueryBuilder class >> asElement [ 
	^self createGraph root. 
]

{ #category : #query }
ApiQueryBuilder class >> courseFullName: aSelected applyTo: anObject [
<rule: #(MoodleCourse fullname)>
^anObject fullName = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> courseId: aSelected applyTo: anObject [
<rule: #(courseid)>
^anObject courseid = aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleCourseCategory: aSelected applyTo: aMoodleCourse [
<rule: #(MoodleCourse category)>
^aMoodleCourse category = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleCourseId: aSelected applyTo: aMoodleCourse [
<rule: #(MoodleCourse id)>
^aMoodleCourse id = aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleCourseShortname: aSelected applyTo: aMoodleCourse [
<rule: #(MoodleCourse shortname)>
^aMoodleCourse shortname = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleGroupName: aSelected applyTo: aMoodleGroup [
<rule: #(MoodleCourse MoodleGroup name)>
^aMoodleGroup name = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleQueryContextlevel: aSelected applyTo: aMoodleQuery [
<rule: #(contextlevel)>
^aMoodleQuery contextlevel = (MoodleEventQuery contextLevels at: aSelected)
]

{ #category : #query }
ApiQueryBuilder class >> moodleQueryEventname: aSelected applyTo: anObject [
<rule: #(eventname)>
^anObject eventname = aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleQueryIp: aSelected applyTo: aMoodleQuery [
<rule: #(ip)>
^aMoodleQuery ip like: aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleQueryTimecreated: aSelected applyTo: aMoodleQuery [
	<rule: #(timecreated)>
	| strings op valueString isTime timeCreated offset valueInt intervalOffset |
	[
	offset := DateAndTime now offset asSeconds.
	aSelected isEmptyOrNil ifTrue: [ ^ false ].
	strings := ' ' split: aSelected.
	op := '='.

	strings size = 2
		ifTrue: [ op := strings first.
			valueString := strings second ]
		ifFalse: [ valueString := aSelected ].
	isTime := valueString includesSubstring: ':'.
	isTime
		ifTrue: [ intervalOffset := 60.	"seconds"
			timeCreated := (aMoodleQuery timecreated + offset) \\ MLogTime dayInSeconds.
			valueInt := MLogTime fromStringtoInt: valueString ]
		ifFalse: [ intervalOffset := MLogTime dayInSeconds.
			timeCreated := aMoodleQuery timecreated.
			valueInt := MLogDate fromStringtoInt: valueString ].
	op = '>' ifTrue: [ ^ timeCreated > valueInt ].
	op = '<' ifTrue: [ ^ timeCreated < valueInt ].
	^ isTime
		ifFalse: [ aMoodleQuery timecreated + offset < (valueInt + intervalOffset)
				& (aMoodleQuery timecreated + offset > valueInt) ]
		ifTrue: [ (aMoodleQuery timecreated + offset) \\ MLogTime dayInSeconds
				< (valueInt + intervalOffset)
				& ((aMoodleQuery timecreated + offset) \\ MLogTime dayInSeconds > valueInt) ] ]
		on: Error
		do: [ :anError | (MoodleFilterError new messageText: 'Неправильный формата даты/времени') signal ]
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserAuth: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser auth)>
^aMoodleUser auth = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserEmail: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser email)>
^aMoodleUser email = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserFirstname: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser firstname)>
^aMoodleUser firstName = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserId: aSelected applyTo: aMoodleUserOrSymbol [
<rule: #(MoodleUser id)>
^aMoodleUserOrSymbol id = aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserLastname: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser lastname)>
^aMoodleUser lastName = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserUsername: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser username)>
^aMoodleUser userName = aSelected.
]

{ #category : #utilities }
ApiQueryBuilder class >> queryMethodSelector: selector class: class [
^(class first asLowercase asString, class copyWithoutFirst)
			, (selector first asUppercase asString, selector copyWithoutFirst)
			, ': aSelected applyTo: a', class .
]

{ #category : #initialization }
ApiQueryBuilder class >> token: aString cancellation: aQueryCancellation [
^self new 
	token: aString;
	cancellation: aQueryCancellation
]

{ #category : #query }
ApiQueryBuilder class >> userId: aSelected applyTo: anObject [
<rule: #(userid)>
^anObject userid = aSelected
]

{ #category : #accessing }
ApiQueryBuilder >> cancellation [
cancellation ifNil: [
	cancellation := QueryCancellation new.
].
^cancellation
]

{ #category : #accessing }
ApiQueryBuilder >> cancellation: aQueryCancellation [ 
cancellation := aQueryCancellation.
]

{ #category : #execution }
ApiQueryBuilder >> execute: aGtSearchQuery [
	| preloaded |
	preloaded := self preloaded: aGtSearchQuery.
	^ (preloaded flatCollect: [:item | self executePreloaded: item ]) withoutDuplicates.
]

{ #category : #'as yet unclassified' }
ApiQueryBuilder >> executePreloaded: aGtSearchFilter [
| res stream chunks readStream aQuery | 
			aQuery := aGtSearchFilter conjForEntity: QueryRoot.
			[res := (MoodleDBEventLog storedInstances sortBlock: [:p1 :p2 | 
				p1 timecreated > p2 timecreated
			]) satisfying: aQuery] on: Error
			 do: [:anError | self cancellation cancel: anError. 
			 	^ {} asAsyncStream
			 ].
			readStream := res readStream.
			self cancellation weak 
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
				self cancellation cancel: anError.
			    nil .
				]
]

{ #category : #utilities }
ApiQueryBuilder >> fetchCourses: aGtSearchFilter [
	| apiCourse byIdQuery searchQuery |
	searchQuery := aGtSearchFilter conjForEntity: MoodleCourse.
	apiCourse := ApiCourse forToken: self token.
	apiCourse subscribeToCancel: self cancellation.
	byIdQuery := aGtSearchFilter forEntity: MoodleCourse attribute: #id.
	byIdQuery isArray
		ifTrue: [ byIdQuery ifEmpty: [ ^ {} asAsyncStream ].
			^ apiCourse completeCoursesChunk: byIdQuery ].
	{'shortname'}
		do: [ :item | 
			| byQuery |
			byQuery := aGtSearchFilter forEntity: MoodleCourse attribute: item.
			byQuery isArray
				ifTrue: [ byQuery ifEmpty: [ ^ {} asAsyncStream ].
					^ (apiCourse completeCoursesChunk: byQuery field: item) select: searchQuery ] ].
	^ apiCourse completeCourses select: searchQuery
]

{ #category : #execution }
ApiQueryBuilder >> fetchGroups: aGtSearchFilter ofCourse: anInteger [ 
	| apiGroup groups |
	apiGroup := ApiGroup forToken: self token.
	GtJustContextStackSignal new emit.
	apiGroup subscribeToCancel: self cancellation.
	groups := (apiGroup groupsOfCourse: anInteger) toArray wait
				select: (aGtSearchFilter conjForEntity: MoodleGroup)
				thenCollect: #id. 
	^apiGroup groupMembers: groups.
]

{ #category : #utilities }
ApiQueryBuilder >> fetchUsers: aGtSearchFilter [ 
	| apiUser dict |
	dict := Dictionary new.
	apiUser := ApiUser forToken: self token.
	apiUser subscribeToCancel: self cancellation.
	{'email'. 'id'. 'username'. 'auth'. 'firstname'. 'lastname'}
		do: [ :item |  
			| byQuery | 
			byQuery := aGtSearchFilter forEntity: MoodleUser attribute: item . 
			byQuery isArray 
				ifTrue: [ byQuery ifEmpty: [ ^ {} asAsyncStream ].
				dict at: item put: byQuery first ]].
	^dict ifEmpty: [apiUser completeUsers] ifNotEmpty:
		 [apiUser completeUsers: dict]
	
]

{ #category : #execution }
ApiQueryBuilder >> preload: aGtSearchFilter [
	| userQuery courseQuery filters res groupQuery courses |
	
	filters := { {aGtSearchFilter} asAsyncStream } asOrderedCollection.
	courseQuery := aGtSearchFilter forEntity: MoodleCourse.
	userQuery := aGtSearchFilter forEntity: MoodleUser.
	groupQuery := aGtSearchFilter forEntity: MoodleGroup.
	
	GtJustContextStackSignal new emit.
	
	[
	courses := (self fetchCourses: aGtSearchFilter) cached.
	courseQuery 
		ifNotEmpty: [ 
			filters add: 
			(courses
					collect: [ :anItem | 
						self class fetchRule: {#courseid} select: anItem id ] )].
						
	groupQuery
		ifNotEmpty: [
			| groups |
			groups :=
				courses flatCollect: [:each |
					(self fetchGroups: aGtSearchFilter ofCourse: each id)
				].
			filters add: 
				(groups collect: [:each | 
					self class fetchRule: {#userid} select: each id
				])
		].
						
	userQuery
		ifNotEmpty: [
			filters add: 
			((self fetchUsers: aGtSearchFilter) cached
					collect: [ :anItem |
						self class fetchRule: {#userid} select: anItem id ])]] on: Error do: [ :anError | 
		self cancellation cancel: anError.
		^ {} asAsyncStream
		].
	
	res := filters reduce: [:xs :ys | 
		xs
		 flatCollect: [ :x |
					ys asyncSimilarCopy map: [ :y | x & y ]]
	].
	
	GtJustContextStackSignal new emit.
	
	^ res asAsyncStream
]

{ #category : #execution }
ApiQueryBuilder >> preloaded: aGtSearchFilter [ 
	^ aGtSearchFilter distributeAsync flatCollect: [ :aQuery | self preload: aQuery ]
]

{ #category : #accessing }
ApiQueryBuilder >> query [
	^ query
]

{ #category : #accessing }
ApiQueryBuilder >> query: aGtSearchFilter [
	query := aGtSearchFilter.
]

{ #category : #accessing }
ApiQueryBuilder >> token [
	^ token
]

{ #category : #accessing }
ApiQueryBuilder >> token: anObject [
	token := anObject
]
