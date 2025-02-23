Class {
	#name : #DEventEnum,
	#superclass : #Object,
	#instVars : [
		'delegatedMethod'
	],
	#category : #'MoodleVKR-Delegates'
}

{ #category : #'as yet unclassified' }
DEventEnum >> accept: aVisior [
aVisior visitStringEnum: self.
]

{ #category : #accessing }
DEventEnum >> delegatedMethod [
	^ delegatedMethod
]

{ #category : #accessing }
DEventEnum >> delegatedMethod: anObject [
	delegatedMethod := anObject
]
