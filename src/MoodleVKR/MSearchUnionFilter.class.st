Class {
	#name : #MSearchUnionFilter,
	#superclass : #GtSearchUnionFilter,
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #'logical operations' }
MSearchUnionFilter >> & aFilter [
	^ MSearchIntersectionFilter forFilter: self filter: aFilter
]

{ #category : #testing }
MSearchUnionFilter >> matches: anObject [
	| resLeft resRight |
	resLeft := left value: anObject.
	resRight := right value: anObject.
	resLeft = #pass & (resRight ~= #pass) ifTrue: [ ^resRight ].
	resLeft ~= #pass & (resRight = #pass) ifTrue: [ ^resLeft ].
	resLeft = #pass & (resRight = #pass) ifTrue: [ ^#pass ].
	^ resLeft | resRight
]

{ #category : #'logical operations' }
MSearchUnionFilter >> | aFilter [
	^ MSearchUnionFilter forFilter: self filter: aFilter
]
