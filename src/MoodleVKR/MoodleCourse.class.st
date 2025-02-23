Class {
	#name : #MoodleCourse,
	#superclass : #Object,
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
<delegate: #DString>
]
