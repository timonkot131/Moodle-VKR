Class {
	#name : #CreateBlockBuilder,
	#superclass : #Object,
	#instVars : [
		'block'
	],
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #initalization }
CreateBlockBuilder class >> from: aBlock [
	^ self new block: aBlock
]

{ #category : #accessing }
CreateBlockBuilder >> block [
	^ block
]

{ #category : #initalization }
CreateBlockBuilder >> block: aBlock [
	block := aBlock.
	
]

{ #category : #'as yet unclassified' }
CreateBlockBuilder >> cull: anObject cull: aModel [
	^ BlockSearchFilter
		block: block
		model: aModel
		selectedValue: anObject
]
