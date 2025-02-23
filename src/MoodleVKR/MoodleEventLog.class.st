Class {
	#name : #MoodleEventLog,
	#superclass : #Object,
	#traits : 'TMEntity',
	#classTraits : 'TMEntity classTrait',
	#instVars : [
		'id',
		'eventname',
		'component',
		'action',
		'target',
		'objecttable',
		'objectid',
		'crud',
		'edulevel',
		'contextid',
		'contextlevel',
		'contextinstanceid',
		'userId',
		'courseId',
		'relateduserid',
		'anonymous',
		'other',
		'timeCreated',
		'origin',
		'ip',
		'realuserid'
	],
	#category : #'MoodleVKR-Model'
}

{ #category : #initalization }
MoodleEventLog class >> reStoreDefinition [
	^super reStoreDefinition
		defineAsID: #id;
		tableName: 'logs';
		define: #eventname as: (String maxSize: 255)
]

{ #category : #'as yet unclassified' }
MoodleEventLog >> <= aMoodleEventLog [ 
^self eventName <= aMoodleEventLog eventName.
]

{ #category : #accessing }
MoodleEventLog >> courseId [
	<delegate: #MoodleCourse>
	^ courseId
]

{ #category : #accessing }
MoodleEventLog >> courseId: anObject [
	courseId := anObject
]

{ #category : #'as yet unclassified' }
MoodleEventLog >> eventName [ 
	<delegate: #DEventEnum>
^ eventname.
]

{ #category : #'as yet unclassified' }
MoodleEventLog >> eventName: aString [
eventname:= aString
]

{ #category : #printing }
MoodleEventLog >> printOn: aStream [
	aStream << eventname.
	^aStream.
]

{ #category : #accessing }
MoodleEventLog >> timeCreated [
	^ timeCreated
]

{ #category : #accessing }
MoodleEventLog >> timeCreated: anObject [
	timeCreated := anObject
]

{ #category : #accessing }
MoodleEventLog >> userId [
	<delegate: #MoodleUser>
	^ userId
]

{ #category : #accessing }
MoodleEventLog >> userId: anObject [
	userId := anObject
]
