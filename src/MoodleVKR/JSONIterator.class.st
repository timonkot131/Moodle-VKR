Class {
	#name : #JSONIterator,
	#superclass : #Object,
	#instVars : [
		'charReader',
		'jsonReader',
		'arrayClass'
	],
	#category : #'MoodleVKR-Utility'
}

{ #category : #initialization }
JSONIterator class >> forStream: aStream [
	| znStream jsonReader |
	znStream := (ZnCharacterReadStream on: aStream).
	jsonReader := (NeoJSONReader on: znStream)
		mapInstVarsFor: MoodleUser; yourself.
	^self new 
		charReader: znStream;
		jsonReader: jsonReader.
		
]

{ #category : #initalization }
JSONIterator class >> forStream: aStream of: aClass [
| instance |
	instance := self forStream: aStream.
	instance jsonReader mapInstVarsFor: aClass.
	instance arrayClass: aClass. 
	^instance.
]

{ #category : #accessing }
JSONIterator >> arrayClass [
	^ arrayClass
]

{ #category : #accessing }
JSONIterator >> arrayClass: anObject [
	arrayClass := anObject
]

{ #category : #accessing }
JSONIterator >> charReader [
	^ charReader
]

{ #category : #accessing }
JSONIterator >> charReader: anObject [
	charReader := anObject
]

{ #category : #'as yet unclassified' }
JSONIterator >> hasNext [
	charReader peek = $] ifTrue: [
		jsonReader close.
		^false
	].
	^charReader atEnd not.
]

{ #category : #accessing }
JSONIterator >> jsonReader [
	^ jsonReader
]

{ #category : #accessing }
JSONIterator >> jsonReader: anObject [
	jsonReader := anObject
]

{ #category : #'as yet unclassified' }
JSONIterator >> next [
	(charReader position = 0 and: [arrayClass = MoodleCourse]) "Уместный костыль"
		ifTrue: [
			[ charReader peek = $[ ] whileFalse: [charReader next].
		].
	[ charReader atEnd ]
		whileFalse: [ charReader peek = ${
				ifTrue: [ 
					
					arrayClass
						ifNotNil: [ arrayClass traceCr. ^ jsonReader nextAs: arrayClass ]
						ifNil: [ ^ jsonReader parseMap ] ]
				ifFalse: [ charReader next ] ]
]
