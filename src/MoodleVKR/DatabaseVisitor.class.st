Class {
	#name : #DatabaseVisitor,
	#superclass : #MoodleVisitor,
	#category : #'MoodleVKR-Database'
}

{ #category : #'as yet unclassified' }
DatabaseVisitor >> visitString: anObject [
self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
DatabaseVisitor >> visitStringEnum: anObject [ 
self subclassResponsibility
]
