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

{ #category : #utility }
JSONIterator >> adjust [
	| buffer |
	buffer := String
			streamContents: [ :out | 
				[ self charReader peek = $[ |
				  self charReader atEnd ]
					whileFalse: [ out nextPut: self charReader next  ] ].
	self charReader atEnd
		ifTrue: [ ((NeoJSONReader on: buffer readStream)
				mapInstVarsFor: MoodleExecutionError;
				nextAs: MoodleExecutionError) signal ]
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
JSONIterator >> close [ 
self jsonReader close
]

{ #category : #'as yet unclassified' }
JSONIterator >> hasNext [
	charReader peek = $] ifTrue: [
		self close.
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
	[ charReader atEnd ]
		whileFalse: [ charReader peek = ${
				ifTrue: [ arrayClass
						ifNotNil: [.
							^ jsonReader nextAs: arrayClass ]
						ifNil: [ ^ jsonReader parseMap ] ]
				ifFalse: [ charReader next ] ]
]
