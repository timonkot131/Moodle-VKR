Class {
	#name : #MoodleQueryViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'title'
	],
	#category : #'MoodleVKR-ViewModels'
}

{ #category : #announcer }
MoodleQueryViewModel >> announcer [
	<return: #Announcer>
	^ announcer 
]

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> initialize [ 
super initialize.
announcer := Announcer new.
]

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> title: aString [ 
	title := aString.
	self announce: (MoodleQueryTitleChangedEvent new title: title).
]
