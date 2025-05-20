Class {
	#name : #MSearchIntersectionFilter,
	#superclass : #GtSearchIntersectionFilter,
	#traits : 'TMFilterExcutor',
	#classTraits : 'TMFilterExcutor classTrait',
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #'logical operations' }
MSearchIntersectionFilter >> & aFilter [
	^ MSearchIntersectionFilter forFilter: self filter: aFilter
]

{ #category : #query }
MSearchIntersectionFilter >> conjForEntity: anEntityClass [
| items |
items := (self forEntity: anEntityClass).
items ifEmpty: [ ^#pass ].
^items reduce: [:x :y | x & y]
]

{ #category : #'logical operations' }
MSearchIntersectionFilter >> distributeAsync [
	| leftQuery rightQuery |
	leftQuery := left distributeAsync.
	rightQuery := right distributeAsync.
	^ leftQuery
		flatCollect: 
		[ :aLeft | rightQuery asyncSimilarCopy collect: [ :aRight | aLeft & aRight ] ]
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

{ #category : #'logical operations' }
MSearchIntersectionFilter >> | aFilter [
	^ MSearchUnionFilter forFilter: self filter: aFilter
]
