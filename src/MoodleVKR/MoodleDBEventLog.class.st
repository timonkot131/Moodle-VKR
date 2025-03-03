"
This class violates the architecture by using ReStore in it's field. But it's faster to do things this way.
"
Class {
	#name : #MoodleDBEventLog,
	#superclass : #Object,
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
		'userid',
		'courseid',
		'relateduserid',
		'anonymous',
		'other',
		'timecreated',
		'origin',
		'ip',
		'realuserid'
	],
	#category : #'MoodleVKR-Database'
}

{ #category : #initalization }
MoodleDBEventLog class >> reStoreDefinition [
	^ super reStoreDefinition
		defineAsID: #id;
		tableName: 'logs';
		define: #eventname as: (String maxSize: 255);
		define: #courseid as: Integer;
		define: #userid as: Integer;
		define: #timecreated as: Integer;
		define: #ip as: (String maxSize: 45)
]

{ #category : #'as yet unclassified' }
MoodleDBEventLog >> <= aMoodleEventLog [ 
^self eventname <= aMoodleEventLog eventname.
]

{ #category : #accessing }
MoodleDBEventLog >> courseId [
	^ courseId
]

{ #category : #accessing }
MoodleDBEventLog >> courseId: anObject [
	courseId := anObject
]

{ #category : #'as yet unclassified' }
MoodleDBEventLog >> eventName [ 
	<delegate: #DEventEnum>
^ eventname.
]

{ #category : #'as yet unclassified' }
MoodleDBEventLog >> eventName: aString [
eventname:= aString
]

{ #category : #accessing }
MoodleDBEventLog >> eventname [
	^ eventname
]

{ #category : #accessing }
MoodleDBEventLog >> eventname: anObject [
	eventname := anObject
]

{ #category : #accessing }
MoodleDBEventLog >> ip [
	^ ip
]

{ #category : #accessing }
MoodleDBEventLog >> ip: anObject [
	ip := anObject
]

{ #category : #printing }
MoodleDBEventLog >> printOn: aStream [
	aStream << eventname.
	^aStream.
]

{ #category : #accessing }
MoodleDBEventLog >> timeCreated [
	^ timeCreated
]

{ #category : #accessing }
MoodleDBEventLog >> timeCreated: anObject [
	timeCreated := anObject
]

{ #category : #accessing }
MoodleDBEventLog >> timecreated [
	^ timecreated
]

{ #category : #accessing }
MoodleDBEventLog >> timecreated: anObject [
	timecreated := anObject
]

{ #category : #accessing }
MoodleDBEventLog >> userId [
	^ userId
]

{ #category : #accessing }
MoodleDBEventLog >> userId: anObject [
	userId := anObject
]
