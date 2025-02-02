Class {
	#name : #MoodleEventLog,
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
	#category : #'MoodleVKR-Database  '
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

{ #category : #'as yet unclassified' }
MoodleEventLog >> eventName [ 
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
