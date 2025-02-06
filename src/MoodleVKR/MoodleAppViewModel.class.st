Class {
	#name : #MoodleAppViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'repository'
	],
	#category : #'MoodleVKR-ViewModels'
}

{ #category : #announcer }
MoodleAppViewModel >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #'as yet unclassified' }
MoodleAppViewModel >> initialize [ 
super initialize.
announcer := Announcer new.
self repository: LogRepository new.
]

{ #category : #accessing }
MoodleAppViewModel >> repository [
	^ repository
]

{ #category : #accessing }
MoodleAppViewModel >> repository: anObject [
	repository := anObject
]
