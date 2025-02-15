Class {
	#name : #MoodleQueryTitleChangedEvent,
	#superclass : #MoodleQueryEvent,
	#instVars : [
		'title'
	],
	#category : #'MoodleVKR-ViewModels'
}

{ #category : #accessing }
MoodleQueryTitleChangedEvent >> title [
	^ title
]

{ #category : #'as yet unclassified' }
MoodleQueryTitleChangedEvent >> title: aString [
	title := aString.
]
