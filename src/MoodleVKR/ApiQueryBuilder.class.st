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

{ #category : #'as yet unclassified' }
ApiQueryBuilder >> courseExcuseMe: anObject [
<rule: #(MoodleCourse wtf)>
]

{ #category : #'as yet unclassified' }
ApiQueryBuilder >> courseFullName: anItem [
<rule: #(MoodleCourse fullName)>

]

{ #category : #rules }
ApiQueryBuilder >> currentQueryArguments [
<return: #aDictionary of: #Collection to: #anObject>
	self currentQueryArguments
]
