Class {
	#name : #JSONIterator,
	#superclass : #Object,
	#instVars : [
		'charReader',
		'jsonReader'
	],
	#category : #'MoodleVKR-Utility'
}

{ #category : #'as yet unclassified' }
JSONIterator class >> forStream: aStream [
	| znStream jsonReader |
	znStream := (ZnCharacterReadStream on: aStream).
	jsonReader := NeoJSONReader on: znStream.
	^self new 
		charReader: znStream;
		jsonReader: jsonReader.
		
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
		charReader next.
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
[charReader atEnd] whileFalse: [
	charReader peek = ${ ifTrue: [
		^jsonReader parseMap.
	] ifFalse: [charReader next.]
].
]
