Class {
	#name : #QueryCancellation,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer'
	],
	#category : #'MoodleVKR-Model'
}

{ #category : #announcer }
QueryCancellation >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #'as yet unclassified' }
QueryCancellation >> cancel [ 
self cancel: #none
]

{ #category : #'as yet unclassified' }
QueryCancellation >> cancel: anObject [
self announce: (MoodleCancelEvent new reason: anObject).
]

{ #category : #'as yet unclassified' }
QueryCancellation >> initialize [
super initialize.
announcer := Announcer new.
]
