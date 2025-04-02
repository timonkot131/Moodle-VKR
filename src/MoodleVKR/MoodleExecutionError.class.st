Class {
	#name : #MoodleExecutionError,
	#superclass : #MoodleError,
	#instVars : [
		'message',
		'exception',
		'errorcode'
	],
	#category : #'MoodleVKR-API'
}

{ #category : #'as yet unclassified' }
MoodleExecutionError >> messageText [ 
^message
]
