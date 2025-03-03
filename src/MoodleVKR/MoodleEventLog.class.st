"
This class violates the architecture by using ReStore in it's field. But it's faster to do things this way.
"
Class {
	#name : #MoodleEventLog,
	#superclass : #Object,
	#instVars : [
		'eventName',
		'ip',
		'timeCreated',
		'user',
		'course'
	],
	#category : #'MoodleVKR-Model'
}

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

{ #category : #accessing }
MoodleEventLog >> ip [
	^ ip
]

{ #category : #accessing }
MoodleEventLog >> ip: anObject [
	ip := anObject
]

{ #category : #accessing }
MoodleEventLog >> user [
	^ user
]

{ #category : #accessing }
MoodleEventLog >> user: anObject [
	user := anObject
]
