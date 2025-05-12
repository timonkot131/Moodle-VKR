Class {
	#name : #MethodSearchFilter,
	#superclass : #GtSearchFilter,
	#traits : 'TMFilterExcutor',
	#classTraits : 'TMFilterExcutor classTrait',
	#instVars : [
		'method',
		'selectedValue',
		'model'
	],
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #factory }
MethodSearchFilter class >> null [
	^MethodNullSearchFilter new
]

{ #category : #'logical operations' }
MethodSearchFilter >> & aFilter [
	^ MSearchIntersectionFilter forFilter: self filter: aFilter
]

{ #category : #'as yet unclassified' }
MethodSearchFilter >> = anObject [
	^ self class = anObject class and: [self hash = anObject hash]
]

{ #category : #converting }
MethodSearchFilter >> asSearchFilter [
^self
]

{ #category : #'as yet unclassified' }
MethodSearchFilter >> attribute [
^self pragmaArgs last
]

{ #category : #'as yet unclassified' }
MethodSearchFilter >> distributeAsync [
^{self} asAsyncStream
]

{ #category : #'as yet unclassified' }
MethodSearchFilter >> entity [
	| pragmaArgs |
	pragmaArgs := self pragmaArgs.
	pragmaArgs size = 1 ifTrue: [ ^ QueryRoot ].
	pragmaArgs size > 1 ifTrue: [ ^ (pragmaArgs last: 2) first asClass ]
]

{ #category : #'as yet unclassified' }
MethodSearchFilter >> hash [ 
^method name hash bitXor: selectedValue hash
]

{ #category : #testing }
MethodSearchFilter >> matches: anObject [
	^ method
		valueWithReceiver: method methodClass
		arguments: {selectedValue.
				anObject}
]

{ #category : #'as yet unclassified' }
MethodSearchFilter >> method [ 
^method
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
MethodSearchFilter >> pragmaArgs [
	^method pragmas first arguments first.
]

{ #category : #'as yet unclassified' }
MethodSearchFilter >> printOn: aStream [ 
aStream << (self pragmaArgs asString, ': ', selectedValue asString ).
]

{ #category : #'as yet unclassified' }
MethodSearchFilter >> selectedValue [ ^selectedValue
]

{ #category : #accessing }
MethodSearchFilter >> selectedValue: anObject [ 
	selectedValue := anObject.
]

{ #category : #'logical operations' }
MethodSearchFilter >> | aFilter [
	^ MSearchUnionFilter forFilter: self filter: aFilter
]
