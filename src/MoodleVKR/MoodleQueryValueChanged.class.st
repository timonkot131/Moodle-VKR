Class {
	#name : #MoodleQueryValueChanged,
	#superclass : #MoodleQueryEvent,
	#instVars : [
		'model',
		'searchFilter',
		'items'
	],
	#category : #'MoodleVKR-ViewModels'
}

{ #category : #accessing }
MoodleQueryValueChanged >> items [
	^ items
]

{ #category : #accessing }
MoodleQueryValueChanged >> items: anObject [
	items := anObject
]

{ #category : #'as yet unclassified' }
MoodleQueryValueChanged >> model [ 
^model
]

{ #category : #'as yet unclassified' }
MoodleQueryValueChanged >> model: anObject [ 
model := anObject
]
