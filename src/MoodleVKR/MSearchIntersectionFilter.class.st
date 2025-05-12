Class {
	#name : #MSearchIntersectionFilter,
	#superclass : #GtSearchIntersectionFilter,
	#traits : 'TMFilterExcutor',
	#classTraits : 'TMFilterExcutor classTrait',
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #'as yet unclassified' }
MSearchIntersectionFilter >> & aFilter [
	^ MSearchIntersectionFilter forFilter: self filter: aFilter
]

{ #category : #'as yet unclassified' }
MSearchIntersectionFilter >> distributeAsync [
	| leftQuery rightQuery |
	leftQuery := left distributeAsync.
	rightQuery := right distributeAsync.
	^ leftQuery
		flatCollect: 
		[ :aLeft | rightQuery asyncSimilarCopy collect: [ :aRight | aLeft & aRight ] ]
]

{ #category : #query }
MSearchIntersectionFilter >> forEntity: anEntityClass [
^self withDeep: #children select: 
	[:x | (x isKindOf: MethodSearchFilter) and: [x entity = anEntityClass] ] collect: #value
]

{ #category : #query }
MSearchIntersectionFilter >> forEntity: anEntityClass attribute: aSymbol [
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
MSearchIntersectionFilter >> forEntity: anEntityClass collect: aCollectBlock [
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
MSearchIntersectionFilter >> forEntity: anEntityClass select: aBlock collect: aCollectBlock [
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
MSearchIntersectionFilter >> isEmpty [
^false
]

{ #category : #'as yet unclassified' }
MSearchIntersectionFilter >> matches: anObject [
	| resLeft resRight |
	resLeft := left value: anObject.
	resRight := right value: anObject.
	^ resLeft & resRight
]

{ #category : #'as yet unclassified' }
MSearchIntersectionFilter >> | aFilter [
	^ MSearchUnionFilter forFilter: self filter: aFilter
]
