Class {
	#name : #AppVisitor,
	#superclass : #MoodleVisitor,
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #'as yet unclassified' }
AppVisitor >> visitString: anObject [
self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
AppVisitor >> visitStringEnum: anObject [ 
self subclassResponsibility
]
