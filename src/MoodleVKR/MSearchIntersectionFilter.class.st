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
MSearchIntersectionFilter >> buildAsyncQuery [
	| leftQuery rightQuery |
	leftQuery := left buildAsyncQuery.
	rightQuery := right buildAsyncQuery.
	^ leftQuery
		flatCollect: 
		[ :aLeft | rightQuery collect: [ :aRight | aLeft & aRight ] ]
]

{ #category : #'as yet unclassified' }
MSearchIntersectionFilter >> matches: anObject [
	| resLeft resRight |
	resLeft := left value: anObject.
	resRight := right value: anObject.
	resLeft = #pass & (resRight ~= #pass) ifTrue: [ ^resRight ].
	resLeft ~= #pass & (resRight = #pass) ifTrue: [ ^resLeft ].
	resLeft = #pass & (resRight = #pass) ifTrue: [ ^#pass ].
	^ resLeft & resRight
]

{ #category : #'as yet unclassified' }
MSearchIntersectionFilter >> | aFilter [
	^ MSearchUnionFilter forFilter: self filter: aFilter
]
