Class {
	#name : #MethodSearchFilter,
	#superclass : #GtSearchFilter,
	#instVars : [
		'method',
		'selectedValue',
		'model'
	],
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #'logical operations' }
MethodSearchFilter >> & aFilter [
	^ MSearchIntersectionFilter forFilter: self filter: aFilter
]

{ #category : #testing }
MethodSearchFilter >> matches: anObject [
	| pragmaArgs |
	pragmaArgs := method pragmas first arguments first.
	pragmaArgs size = 1 & (anObject class = SSWDBBlockArgument)
		ifTrue: [
		[ ^ method
				valueWithReceiver: method methodClass
				arguments: {selectedValue.
						anObject}] on: Error do: [^false] ].
	(pragmaArgs size > 1 and: [ ((pragmaArgs last: 2) first asClass  = anObject class)])
		ifTrue: [ ^ method
				valueWithReceiver: method methodClass
				arguments: {selectedValue.
						anObject} ].
	^#pass
]

{ #category : #accessing }
MethodSearchFilter >> method: aCompiledMethod [ 
method := aCompiledMethod.
]

{ #category : #accessing }
MethodSearchFilter >> model: aModel [ 
	model := aModel.
]

{ #category : #accessing }
MethodSearchFilter >> pragma [
	^method 
]

{ #category : #accessing }
MethodSearchFilter >> selectedValue: anObject [ 
	selectedValue := anObject.
]

{ #category : #'logical operations' }
MethodSearchFilter >> | aFilter [
	^ MSearchUnionFilter forFilter: self filter: aFilter
]
