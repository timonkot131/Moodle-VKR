Class {
	#name : #MoodleSourceViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'model',
		'sourceModel',
		'announcer'
	],
	#category : #'MoodleVKR-ViewModels'
}

{ #category : #announcer }
MoodleSourceViewModel >> announcer [
	<return: #Announcer>
	^announcer.
]

{ #category : #'as yet unclassified' }
MoodleSourceViewModel >> initialize [ 
announcer := Announcer new.
]

{ #category : #accessing }
MoodleSourceViewModel >> model [
	^ model
]

{ #category : #'as yet unclassified' }
MoodleSourceViewModel >> model: anObject [
	model := anObject.
	self announce: (MoodleModelChanged new model: model).
]

{ #category : #'as yet unclassified' }
MoodleSourceViewModel >> onModelChanged: aMoodleModelChanged [
	self sourceModel: aMoodleModelChanged
]

{ #category : #'as yet unclassified' }
MoodleSourceViewModel >> setModel: anObject [
]

{ #category : #'as yet unclassified' }
MoodleSourceViewModel >> sourceModel: anObject [ 
	sourceModel := anObject
]
