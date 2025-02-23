Class {
	#name : #MoodleCourse,
	#superclass : #Object,
	#traits : 'TMEntity',
	#classTraits : 'TMEntity classTrait',
	#instVars : [
		'fullname'
	],
	#category : #'MoodleVKR-Model'
}

{ #category : #'as yet unclassified' }
MoodleCourse >> delegatedMethod: aCompiledMethod [
]

{ #category : #'as yet unclassified' }
MoodleCourse >> fullName [
<delegate: #DStringValue>
^fullname 
]
