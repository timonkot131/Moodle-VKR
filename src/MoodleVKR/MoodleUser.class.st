Class {
	#name : #MoodleUser,
	#superclass : #Object,
	#instVars : [
		'email',
		'fullname',
		'id',
		'profileimageurlsmall',
		'userName'
	],
	#category : #'MoodleVKR-Model'
}

{ #category : #accessing }
MoodleUser >> email [
	^ email
]

{ #category : #accessing }
MoodleUser >> email: aString [
	email := aString
]

{ #category : #accessing }
MoodleUser >> fullName [
	^ fullname 
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
MoodleUser >> printOn: aStream [
aStream << ('e-mail: "', email, '",').
aStream << (' Полное имя: "', fullname, '"').   
]

{ #category : #accessing }
MoodleUser >> userName [
	^ userName
]

{ #category : #accessing }
MoodleUser >> userName: anObject [
	userName := anObject
]
