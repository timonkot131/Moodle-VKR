Class {
	#name : #MConfig,
	#superclass : #Object,
	#classInstVars : [
		'serverName',
		'token',
		'isHttps'
	],
	#category : #'MoodleVKR-Database'
}

{ #category : #accessing }
MConfig class >> clientFor: aString [
	| request |
	request := ZnClient new.
	MConfig isHttps 
		ifTrue: [ request https ] 
		ifFalse: [ request http ].
	request
		host: self serverName;
		addPath: 'webservice/rest/server.php';
		queryAt: 'wsfunction' put: aString;
		queryAt: 'wstoken' put: token;
		queryAt: 'moodlewsrestformat' add: 'json'.

	^ request
]

{ #category : #accessing }
MConfig class >> isHttps [
	^ isHttps
]

{ #category : #accessing }
MConfig class >> isHttps: anObject [
	isHttps := anObject
]

{ #category : #accessing }
MConfig class >> serverName [
	^serverName.
]

{ #category : #accessing }
MConfig class >> serverName: anObject [
	serverName := anObject
]

{ #category : #accessing }
MConfig class >> token [
	^ token
]

{ #category : #accessing }
MConfig class >> token: anObject [
	token := anObject
]
