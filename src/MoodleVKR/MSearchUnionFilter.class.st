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

{ #category : #testing }
MSearchUnionFilter >> isEmpty [
^ false
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
