Class {
	#name : #MoodleEventLog,
	#superclass : #Object,
	#instVars : [
		'id',
		'eventname'
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
MoodleEventLog >> eventName [ 
^ eventname.
]

{ #category : #'as yet unclassified' }
MoodleEventLog >> eventName: aString [
eventname:= aString
]
