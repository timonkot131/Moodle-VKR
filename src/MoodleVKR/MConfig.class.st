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

{ #category : #'as yet unclassified' }
MConfig class >> httpsDescription [
<magritteDescription>
^ MABooleanDescription new 
		label: 'Https?';
		priority: 3;
		accessor: #isHttps;
		editorAptitude:  [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ].
]

{ #category : #'as yet unclassified' }
MConfig class >> initialize [
isHttps := false.
token := ''.
serverName := 'localhost'
]

{ #category : #accessing }
MConfig class >> isHttps [
	^ isHttps
]

{ #category : #accessing }
MConfig class >> isHttps: anObject [
	isHttps := anObject
]

{ #category : #'as yet unclassified' }
MConfig class >> serverDescription [
<magritteDescription>
^ MAStringDescription new 
		label: 'Сервер';
		priority: 1;
		accessor: #serverName;
		editorAptitude:  [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ].
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

{ #category : #'as yet unclassified' }
MConfig class >> tokenDescription [
<magritteDescription>
	^ MAPasswordDescription new
		label: 'Токен';
		priority: 2;
		accessor: #token;
		editorAptitude:  [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ].
]
