Class {
	#name : #QuerySelector,
	#superclass : #Object,
	#instVars : [
		'associtation',
		'coder'
	],
	#category : #'MoodleVKR-Model'
}

{ #category : #'as yet unclassified' }
QuerySelector class >> forAssociation: aCollection [
]

{ #category : #acccessing }
QuerySelector >> association: aCollection [
	associtation := aCollection
	
]

{ #category : #'as yet unclassified' }
QuerySelector >> associtiation [
	^associtation
]

{ #category : #'as yet unclassified' }
QuerySelector >> coder [
	^coder
]

{ #category : #acccessing }
QuerySelector >> coder: aBrMenu [
	coder := aBrMenu
]
