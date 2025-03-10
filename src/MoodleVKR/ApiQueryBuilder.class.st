Class {
	#name : #ApiQueryBuilder,
	#superclass : #Object,
	#traits : 'TMQueryBuilder',
	#classTraits : 'TMQueryBuilder classTrait',
	#instVars : [
		'currentQueryArguments',
		'query'
	],
	#category : #'MoodleVKR-API'
}

{ #category : #converting }
ApiQueryBuilder class >> asElement [ 
	^self createGraph root. 
]

{ #category : #query }
ApiQueryBuilder class >> courseFullName: aSelected applyTo: anObject [
<rule: #(MoodleCourse fullname)>
^anObject fullName = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleQueryEventname: aSelected applyTo: anObject [
<rule: #(eventname)>
anObject class ~= SSWDBBlockArgument ifTrue: [^#pass].
^anObject eventname = aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserEmail: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser email)>
^aMoodleUser email = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserId: aSelected applyTo: aMoodleUserOrSymbol [
<rule: #(MoodleUser id)>
^aMoodleUserOrSymbol id = aSelected
]

{ #category : #'as yet unclassified' }
ApiQueryBuilder >> acceptQuery: aBlock [
	query := aBlock.
]

{ #category : #rules }
ApiQueryBuilder >> argument: aBlock for: aCollection [
self currentQueryFilters at: aCollection put: aBlock.
]

{ #category : #utilites }
ApiQueryBuilder >> check: anObject [
(query value: anObject) = #pass ifTrue: 
	[^ #pass.]
	ifFalse: [^ query]
]

{ #category : #rules }
ApiQueryBuilder >> currentQueryFilters [
<return: #aDictionary of: #Collection to: #anObject>
	self currentQueryFilters
]

{ #category : #execution }
ApiQueryBuilder >> execute [
	| users anApiUser logs userQuery |
	anApiUser := ApiUser forToken: 'f8ae68ba7886638627da9f059ca3555e'.
	userQuery := (self check: MoodleUser new).
	
	userQuery ~= #pass 
		ifTrue:  [ 
			| emails |
			users := anApiUser completeUsers filter:  userQuery.
			emails := self check: #moodleuser_email.
			
			
			
		] 
		ifFalse: [].
	
	logs := MoodleDBEventLog storedInstances filter: (self check: MoodleDBEventLog blockArgument).
]
