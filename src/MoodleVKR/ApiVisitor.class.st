Class {
	#name : #ApiVisitor,
	#superclass : #MoodleVisitor,
	#category : #'MoodleVKR-API'
}

{ #category : #'as yet unclassified' }
ApiVisitor >> visitString: anObject [
self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
ApiVisitor >> visitStringEnum: anObject [ 
self subclassResponsibility
]
