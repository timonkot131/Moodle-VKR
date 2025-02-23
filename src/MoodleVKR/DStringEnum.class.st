Class {
	#name : #DStringEnum,
	#superclass : #Object,
	#instVars : [
		'delegatedMethod'
	],
	#category : #'MoodleVKR-Delegates'
}

{ #category : #'as yet unclassified' }
DStringEnum >> accept: aVisior [
aVisior visitStringEnum: self.
]

{ #category : #accessing }
DStringEnum >> delegatedMethod [
	^ delegatedMethod
]

{ #category : #accessing }
DStringEnum >> delegatedMethod: anObject [
	delegatedMethod := anObject
]
