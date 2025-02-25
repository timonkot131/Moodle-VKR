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

{ #category : #rules }
ApiQueryBuilder >> currentQueryArguments [
<return: #aDictionary of: #Collection to: #anObject>
	self currentQueryArguments
]

{ #category : #rules }
ApiQueryBuilder >> rules [
<return: #aDictionary of: #Collection to: #CompiledMethod>
	^(self pragmas select: [:aPragma | aPragma selector = #rule:] thenCollect: 
		[ :aPragma | 
			| anArgument |
			anArgument := MoodleEventQuery parseRule: aPragma arguments first. 
			anArgument -> aPragma method.
			 ]) asDictionary
			
]
