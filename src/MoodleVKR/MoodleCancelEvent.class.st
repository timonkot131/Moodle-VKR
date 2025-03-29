Class {
	#name : #MoodleCancelEvent,
	#superclass : #MoodleAppEvent,
	#instVars : [
		'reason'
	],
	#category : #'MoodleVKR-ViewModels'
}

{ #category : #accessing }
MoodleCancelEvent >> reason [
	^ reason
]

{ #category : #accessing }
MoodleCancelEvent >> reason: anObject [
	reason := anObject
]
