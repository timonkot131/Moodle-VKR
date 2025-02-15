Class {
	#name : #MoodleModelChanged,
	#superclass : #MoodleAppEvent,
	#instVars : [
		'model'
	],
	#category : #'MoodleVKR-ViewModels'
}

{ #category : #accessing }
MoodleModelChanged >> model [
	^ model
]

{ #category : #accessing }
MoodleModelChanged >> model: anObject [
	model := anObject
]
