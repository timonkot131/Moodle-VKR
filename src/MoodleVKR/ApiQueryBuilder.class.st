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
ApiQueryBuilder class >> asElement [ 
	^self createGraph root. 
]

{ #category : #queries }
ApiQueryBuilder class >> courseFullName: anItem [
<rule: #(MoodleCourse fullname)>
^4
]

{ #category : #accessing }
ApiQueryBuilder class >> edgeStencil: selfRules extra: extraRules [
	^ [ :item :from :to | 
	| origin target color |
	origin := from userData at: #item.
	target := to userData at: #item.
	color := (selfRules
			includes: {origin.
					target}) ifTrue: [ Color blue ] ifFalse: [ Color red ].
	(extraRules
		includes: {origin.
				target}) ifTrue: [ color := Color green ].
	BlLineElement new
		zIndex: -1;
		border: (BlBorder paint: (color alpha: 0.5)) ]
]

{ #category : #rules }
ApiQueryBuilder >> argument: aBlock for: aCollection [
self currentQueryFilters at: aCollection put: aBlock.
]

{ #category : #rules }
ApiQueryBuilder >> currentQueryFilters [
<return: #aDictionary of: #Collection to: #anObject>
	self currentQueryFilters
]
