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
MethodSearchFilter >> matches: anObjectOrSymbol [
	"#pass? Символ? Я фильтрую, но также могу выдавать информацию о самом запросе"
	| pragmaArgs |
	pragmaArgs := method pragmas first arguments first.
	pragmaArgs size = 1
		ifTrue: [ ^ method
				valueWithReceiver: method methodClass
				arguments: {selectedValue.
						anObjectOrSymbol} ].
	pragmaArgs size > 1
		ifTrue: [
			| selector class |
			class := (pragmaArgs last: 2) first.
			selector := pragmaArgs last.
			"Один из способов достать выбранное значение"
			(class asLowercase, '_', selector) asSymbol = anObjectOrSymbol ifTrue: [ ^ {selectedValue} ].
			(pragmaArgs last: 2) first asClass = anObjectOrSymbol class
				ifFalse: [ ^ #pass ].
			^ method
				valueWithReceiver: method methodClass
				arguments: {selectedValue.
						anObjectOrSymbol} ].
	^ #pass
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
