Class {
	#name : #MSearchUnionFilter,
	#superclass : #GtSearchUnionFilter,
	#traits : 'TMFilterExcutor',
	#classTraits : 'TMFilterExcutor classTrait',
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #'logical operations' }
MSearchUnionFilter >> & aFilter [
	^ MSearchIntersectionFilter forFilter: self filter: aFilter
]

{ #category : #'as yet unclassified' }
MSearchUnionFilter >> distributeAsync [
	|leftQuery rightQuery|
	leftQuery := left distributeAsync. 
	rightQuery := right distributeAsync.
	^leftQuery merge: rightQuery.
]

{ #category : #query }
MSearchUnionFilter >> forEntity: anEntityClass [
^self deep: #children select: 
	[:x | (x isKindOf: MethodSearchFilter) and: [x entity = anEntityClass] ]
]

{ #category : #query }
MSearchUnionFilter >> forEntity: anEntityClass attribute: aSymbol [
| items |
items := ((self forEntity: anEntityClass) select: [:x | x attribute = aSymbol] thenCollect: #selectedValue) asSet.
"Требуется логическое И над элементами множества. Имеется ввиду, что идет сбор"
"По одному аттрибуту"
"Если в будет множество с И с разными элементами и уникальными аттрибутам, то запрос никогда не пройдет"
(items size > 1) ifTrue: [
	^{}
].
^items.
]

{ #category : #'as yet unclassified' }
MSearchUnionFilter >> forEntity: anEntityClass collect: aCollectBlock [
| items |
items := (self forEntity: anEntityClass) collect: aCollectBlock.
items := items asSet.
"Требуется логическое И над элементами множества. Имеется ввиду, что идет сбор"
"По одному аттрибуту"
"Если в будет множество с И с разными элементами и уникальными аттрибутам, то запрос никогда не пройдет"
(items size > 1) ifTrue: [
	^{}
].
^items.
]

{ #category : #'as yet unclassified' }
MSearchUnionFilter >> forEntity: anEntityClass select: aBlock collect: aCollectBlock [
| items |
items := (self forEntity: anEntityClass attribute: aBlock) collect: aCollectBlock.
items := items asSet.
"Требуется логическое И над элементами множества. Имеется ввиду, что идет сбор"
"По одному аттрибуту"
"Если в будет множество с И с разными элементами и уникальными аттрибутам, то запрос никогда не пройдет"
(items size > 1) ifTrue: [
	^{}
].
^items.
]

{ #category : #testing }
MSearchUnionFilter >> isEmpty [
^ false
]

{ #category : #testing }
MSearchUnionFilter >> matches: anObject [
	| resLeft resRight |
	(Error new messageText: 'Isn''t expected to call for or. Use and instead') emit.
	resLeft := left value: anObject.
	resRight := right value: anObject.
	^ resLeft | resRight
]

{ #category : #'logical operations' }
MSearchUnionFilter >> | aFilter [
	^ MSearchUnionFilter forFilter: self filter: aFilter
]
