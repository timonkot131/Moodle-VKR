Class {
	#name : #MoodleUser,
	#superclass : #Object,
	#instVars : [
		'email',
		'fullname',
		'id',
		'profileimageurlsmall'
	],
	#category : #'MoodleVKR-Model'
}

{ #category : #'as yet unclassified' }
MoodleUser >> delegatedMethod: aCompiledMethod [
]

{ #category : #accessing }
MoodleUser >> email [

^email 

]

{ #category : #accessing }
MoodleUser >> fullname [
	^ fullname
]

{ #category : #accessing }
MoodleUser >> fullname: anObject [
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
