"
This class violates the architecture by using ReStore in it's field. But it's faster to do things this way.
"
Class {
	#name : #MoodleEventLog,
	#superclass : #Object,
	#instVars : [
		'eventName',
		'ip',
		'timecreated',
		'user',
		'course',
		'id',
		'contextLevel'
	],
	#category : #'MoodleVKR-Model'
}

{ #category : #'as yet unclassified' }
MoodleEventLog >> = anObject [
(anObject isKindOf: self class) ifFalse: [^false].
^self id = anObject id
]

{ #category : #accessing }
MoodleEventLog >> contextLevel [
	^ contextLevel
]

{ #category : #accessing }
MoodleEventLog >> contextLevel: anObject [
	contextLevel := anObject
]

{ #category : #accessing }
MoodleEventLog >> course [
	^ course
]

{ #category : #accessing }
MoodleEventLog >> course: anObject [
	course := anObject
]

{ #category : #accessing }
MoodleEventLog >> eventName [
	^ eventName 
]

{ #category : #accessing }
MoodleEventLog >> eventName: anObject [
	eventName := anObject
]

{ #category : #'as yet unclassified' }
MoodleEventLog >> hash [ 
^id hash
]

{ #category : #accessing }
MoodleEventLog >> id [
	^ id
]

{ #category : #accessing }
MoodleEventLog >> id: anObject [
	id := anObject
]

{ #category : #accessing }
MoodleEventLog >> ip [
	^ ip
]

{ #category : #accessing }
MoodleEventLog >> ip: anObject [
	ip := anObject
]

{ #category : #'as yet unclassified' }
MoodleEventLog >> printOn: aStream [
	aStream << eventName.
	aStream << ('; user: ', user email).
	^aStream. 
]

{ #category : #'as yet unclassified' }
MoodleEventLog >> timeCreated [
^timecreated
]

{ #category : #'as yet unclassified' }
MoodleEventLog >> timeCreated: aNumber [
timecreated := aNumber.
]

{ #category : #accessing }
MoodleEventLog >> user [
	^ user
]

{ #category : #accessing }
MoodleEventLog >> user: anObject [
	user := anObject
]
