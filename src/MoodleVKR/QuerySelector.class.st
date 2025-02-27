Class {
	#name : #QuerySelector,
	#superclass : #Object,
	#instVars : [
		'associtation',
		'coder'
	],
	#category : #'MoodleVKR-Model'
}

{ #category : #initialization }
QuerySelector class >> forAssociation: anArray sourceClass: aClass [
	| selector instance |
	selector := anArray second.
	instance := self new association: anArray.
	^(aClass rules associations
		collect: [:x | (MoodleEventQuery describe: {x key}) first -> x value ])
		detect: [ :x | x key includes: anArray ]
		ifFound: [ :x | 
			instance coder: (GtPharoMethodCoderMenu new forMethod: x value) ]
		ifNone: [ instance coder: (instance newCoder: aClass) ].

]

{ #category : #testing }
QuerySelector >> = aQuerySelector [
(aQuerySelector class = self class) ifTrue: [^self association = aQuerySelector association].
^false
]

{ #category : #'as yet unclassified' }
QuerySelector >> asElement [
| element |
	element := coder asElement.
element aptitude - BrMenuPinnableAptitude.
^element.
]

{ #category : #accessor }
QuerySelector >> association [
	^associtation
]

{ #category : #accessor }
QuerySelector >> association: anArray [
	associtation := anArray
]

{ #category : #accessor }
QuerySelector >> coder [
	^coder
]

{ #category : #accessor }
QuerySelector >> coder: aBrMenu [
	coder := aBrMenu
]

{ #category : #accessor }
QuerySelector >> first [ 
	^associtation first
]

{ #category : #accessor }
QuerySelector >> hash [ 
	^self association hash.
]

{ #category : #creation }
QuerySelector >> newCoder: aClass [
	| rule class selector methodName pragma body |
	rule := self serializeRule.
	class := associtation first asString.
	selector := associtation second asString.
	methodName := (class first asLowercase asString, class copyWithoutFirst)
			, (selector first asUppercase asString, selector copyWithoutFirst)
			, ': anObject'.
	pragma := '<rule: ', rule ,'>'.
	body := {methodName. pragma} asStringWithCr.
	^ GtPharoNewMethodCoderMenu new forClass: aClass source: body; shouldHaveHeader: false; protocol: 'query'. 
]

{ #category : #printing }
QuerySelector >> printOn: aStream [ 
aStream << self association asString
]

{ #category : #accessor }
QuerySelector >> second [ ^associtation second
]

{ #category : #creation }
QuerySelector >> serializeRule [
	| ruleString record |
	record := (MoodleEventQuery describe: MoodleEventQuery ruleHierarchy)
			detect: [ :x | x includes: associtation ].
	ruleString := record
			reject: [ :x | x = MoodleQuery ]
			thenCollect: [ :x | x isArray ifTrue: [ x second asString ] ifFalse: [ x asString ] ].
	^ ruleString asString copyWithout: $'
]

{ #category : #accessor }
QuerySelector >> size [
^associtation size
]
