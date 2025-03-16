Class {
	#name : #MoodleCourse,
	#superclass : #Object,
	#instVars : [
		'fullname',
		'id',
		'shortname',
		'categoryname'
	],
	#category : #'MoodleVKR-Model'
}

{ #category : #accessing }
MoodleCourse >> category [
	^ categoryname
]

{ #category : #accessing }
MoodleCourse >> category: anObject [
	categoryname := anObject
]

{ #category : #'as yet unclassified' }
MoodleCourse >> delegatedMethod: aCompiledMethod [
]

{ #category : #'as yet unclassified' }
MoodleCourse >> fullName [ 

]

{ #category : #accessing }
MoodleCourse >> id [
	^ id
]

{ #category : #accessing }
MoodleCourse >> id: anObject [
	id := anObject
]

{ #category : #'as yet unclassified' }
MoodleCourse >> printOn: aStream [
aStream << fullname.
^aStream.
]

{ #category : #accessing }
MoodleCourse >> shortname [
	^ shortname
]

{ #category : #accessing }
MoodleCourse >> shortname: anObject [
	shortname := anObject
]
