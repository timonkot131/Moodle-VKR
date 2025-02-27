Class {
	#name : #ApiQueryBuilder,
	#superclass : #Object,
	#traits : 'TMQueryBuilder',
	#classTraits : 'TMQueryBuilder classTrait',
	#instVars : [
		'currentQueryArguments'
	],
	#category : #'MoodleVKR-API'
}

{ #category : #queries }
ApiQueryBuilder >> courseFullName: anItem [
<rule: #(MoodleCourse fullName)>
^4
]

{ #category : #rules }
ApiQueryBuilder >> currentQueryArguments [
<return: #aDictionary of: #Collection to: #anObject>
	self currentQueryArguments
]
