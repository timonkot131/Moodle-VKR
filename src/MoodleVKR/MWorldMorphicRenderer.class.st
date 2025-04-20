Class {
	#name : #MWorldMorphicRenderer,
	#superclass : #GtNullWorldMorphicRenderer,
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #initalization }
MWorldMorphicRenderer class >> initialize [
	super initialize.
]

{ #category : #'as yet unclassified' }
MWorldMorphicRenderer class >> isApplicableFor: aWorld [
	<return: #Boolean>
	^true
]

{ #category : #'as yet unclassified' }
MWorldMorphicRenderer class >> priority [ 
	^ 200
]
