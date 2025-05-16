Trait {
	#name : #TMFilterExcutor,
	#category : #'MoodleVKR-Model'
}

{ #category : #converting }
TMFilterExcutor >> asSearchFilter [
^self
]

{ #category : #query }
TMFilterExcutor >> conjForEntity: anEntityClass [
| items |
items := (self forEntity: anEntityClass).
items ifEmpty: [ ^#pass ].
^items reduce: [:x :y | x & y]
]

{ #category : #query }
TMFilterExcutor >> forEntity: anEntityClass [
^self withDeep: #children select: 
	[:x | (x isKindOf: MethodSearchFilter) and: [x entity = anEntityClass] ] collect: #value
]

{ #category : #query }
TMFilterExcutor >> forEntity: anEntityClass attribute: aSymbol [
| items |
items := ((self forEntity: anEntityClass) select: [:x | x attribute = aSymbol] thenCollect: #selectedValue) asSet.
"Требуется логическое И над элементами множества. Имеется ввиду, что идет сбор"
"По одному аттрибуту"
"Если в будет множество с И с разными элементами и уникальными аттрибутам, то запрос никогда не пройдет"
(items size > 1) ifTrue: [ ^{} ].
items ifEmpty: [ ^#pass ].
^items asArray.
]

{ #category : #view }
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

{ #category : #view }
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
