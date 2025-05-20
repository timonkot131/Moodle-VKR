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
		'contextinstanceid',
		'userid',
		'courseid',
		'relateduserid',
		'anonymous',
		'other',
		'timecreated',
		'origin',
		'ip',
		'realuserid',
		'contextlevel'
	],
	#category : #'MoodleVKR-Database'
}

{ #category : #accessing }
MoodleDBEventLog class >> blockArgument [
	^ (SSWDBBlockParser newForReStore: ReStore argumentClass: self)
		newBlockArgument
]

{ #category : #initalization }
MoodleDBEventLog class >> reStoreDefinition [
	^ super reStoreDefinition
		defineAsID: #id;
		tableName: 'logs';
		define: #contextlevel as: Integer;
		define: #eventname as: (String maxSize: 255);
		define: #courseid as: Integer;
		define: #userid as: Integer;
		define: #relateduserid as: Integer;
		define: #timecreated as: Integer;
		define: #ip as: (String maxSize: 45)
]

{ #category : #'as yet unclassified' }
MoodleDBEventLog >> <= aMoodleEventLog [ 
^self id <= aMoodleEventLog id.
]

{ #category : #accessing }
MoodleDBEventLog >> contextlevel [
	^ contextlevel
]

{ #category : #accessing }
MoodleDBEventLog >> contextlevel: anObject [
	contextlevel := anObject
]

{ #category : #accessing }
MoodleDBEventLog >> courseid [
	^ courseid
]

{ #category : #accessing }
MoodleDBEventLog >> courseid: anObject [
	courseid := anObject
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
MoodleDBEventLog >> id [
	^ id
]

{ #category : #accessing }
MoodleDBEventLog >> id: anObject [
	id := anObject
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
	aStream << ('; userid: ', userid asString).
	aStream << ('; courseid: ', courseid asString).
	^aStream.
]

{ #category : #accessing }
MoodleDBEventLog >> relateduserid [
	^ relateduserid
]

{ #category : #accessing }
MoodleDBEventLog >> relateduserid: anObject [
	relateduserid := anObject
]

{ #category : #utilities }
MoodleDBEventLog >> timeAndDate [
^DateAndTime fromUnixTime: self timecreated
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
MoodleDBEventLog >> userid [
	^ userid
]

{ #category : #accessing }
MoodleDBEventLog >> userid: anObject [
	userid := anObject
]
