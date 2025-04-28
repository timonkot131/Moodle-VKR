Class {
	#name : #MoodleUser,
	#superclass : #Object,
	#instVars : [
		'email',
		'fullname',
		'id',
		'profileimageurlsmall',
		'username',
		'firstname',
		'lastname',
		'auth'
	],
	#category : #'MoodleVKR-Model'
}

{ #category : #accessing }
MoodleUser >> auth [
	^ auth ifNil: ['Нет']
]

{ #category : #accessing }
MoodleUser >> auth: anObject [
	auth := anObject
]

{ #category : #accessing }
MoodleUser >> email [
	^ email ifNil: ['Нет']
]

{ #category : #accessing }
MoodleUser >> email: aString [
	email := aString
]

{ #category : #'as yet unclassified' }
MoodleUser >> firstName [
^firstname ifNil: ['Нет']
]

{ #category : #'as yet unclassified' }
MoodleUser >> firstName: aString [
firstname := aString
]

{ #category : #accessing }
MoodleUser >> fullName [
	^ fullname ifNil: ['Нет']
]

{ #category : #accessing }
MoodleUser >> fullName: anObject [
	fullname := anObject
]

{ #category : #accessing }
MoodleUser >> id [
	^ id
]

{ #category : #accessing }
MoodleUser >> id: anObject [
	id := anObject
]

{ #category : #'as yet unclassified' }
MoodleUser >> lastName [
^lastname ifNil: ['Нет']
]

{ #category : #'as yet unclassified' }
MoodleUser >> lastName: aString [
lastname := aString
]

{ #category : #'as yet unclassified' }
MoodleUser >> printOn: aStream [
aStream << ('e-mail: "', email, '",').
aStream << (' Полное имя: "', fullname, '"').
]

{ #category : #accessing }
MoodleUser >> userName [
	^ username ifNil: ['Нет']
]

{ #category : #accessing }
MoodleUser >> userName: anObject [
	username := anObject
]
