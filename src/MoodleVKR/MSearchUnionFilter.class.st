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

{ #category : #testing }
MSearchUnionFilter >> = anObject [
	^ self class = anObject class and: [self hash = anObject hash]
]

{ #category : #'logical operations' }
MSearchUnionFilter >> distributeAsync [
	|leftQuery rightQuery|
	leftQuery := left distributeAsync. 
	rightQuery := right distributeAsync.
	^leftQuery merge: rightQuery.
]

{ #category : #'as yet unclassified' }
MSearchUnionFilter >> hash [ 
^self leftFilter hash bitXor: self rightFilter hash
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
