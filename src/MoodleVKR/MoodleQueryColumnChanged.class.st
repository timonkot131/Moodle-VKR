Class {
	#name : #MoodleQueryColumnChanged,
	#superclass : #MoodleQueryEvent,
	#instVars : [
		'columns'
	],
	#category : #'MoodleVKR-ViewModels'
}

{ #category : #accessing }
MoodleQueryColumnChanged >> columns [
	^ columns
]

{ #category : #accessing }
MoodleQueryColumnChanged >> columns: anObject [
	columns := anObject
]
