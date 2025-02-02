Class {
	#name : #IteratorStream,
	#superclass : #Object,
	#instVars : [
		'readStream'
	],
	#category : #'MoodleVKR-Utility'
}

{ #category : #initialization }
IteratorStream class >> forPosStream: aStream [ 
	^self new readStream: aStream
]

{ #category : #converting }
IteratorStream >> asAsyncStream [ 
	^AsyncIteratorStream forIterator: self.
]

{ #category : #accesing }
IteratorStream >> hasNext [
	^readStream atEnd not.
]

{ #category : #accesing }
IteratorStream >> next [ 
	^readStream next.
]

{ #category : #accesing }
IteratorStream >> readStream [
	^ readStream
]

{ #category : #accesing }
IteratorStream >> readStream: aStream [ 
	readStream := aStream
]
