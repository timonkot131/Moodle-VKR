Class {
	#name : #MoodleQueryValueChanged,
	#superclass : #MoodleQueryEvent,
	#instVars : [
		'model',
		'searchFilter'
	],
	#category : #'MoodleVKR-ViewModels'
}

{ #category : #'as yet unclassified' }
MoodleQueryValueChanged >> model [ 
^model
]

{ #category : #'as yet unclassified' }
MoodleQueryValueChanged >> model: anObject [ 
model := anObject
]

{ #category : #accessing }
MoodleQueryValueChanged >> searchFilter [
	^ searchFilter
]

{ #category : #accessing }
MoodleQueryValueChanged >> searchFilter: anObject [
	searchFilter := anObject
]
