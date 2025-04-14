Class {
	#name : #MoodleGroup,
	#superclass : #Object,
	#instVars : [
		'name',
		'id',
		'courseid'
	],
	#category : #'MoodleVKR-Model'
}

{ #category : #accessing }
MoodleGroup >> courseid [
	^ courseid
]

{ #category : #accessing }
MoodleGroup >> courseid: anObject [
	courseid := anObject
]

{ #category : #accessing }
MoodleGroup >> id [
	^ id
]

{ #category : #accessing }
MoodleGroup >> id: anObject [
	id := anObject
]

{ #category : #accessing }
MoodleGroup >> name [
	^ name
]

{ #category : #accessing }
MoodleGroup >> name: anObject [
	name := anObject
]
