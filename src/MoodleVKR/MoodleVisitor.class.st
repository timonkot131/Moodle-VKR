Class {
	#name : #MoodleVisitor,
	#superclass : #Object,
	#category : #'MoodleVKR-Model'
}

{ #category : #'as yet unclassified' }
MoodleVisitor >> visitString: anObject [
self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
MoodleVisitor >> visitStringEnum: anObject [ 
self subclassResponsibility
]
