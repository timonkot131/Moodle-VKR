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

{ #category : #initalization }
CreateBlockBuilder class >> from: aClass withMethod: aCompiledMethod [
^self from: 
	[ :aSelectedValue :aValue | 
		aCompiledMethod  valueWithReceiver: aClass arguments: {aSelectedValue. aValue}
	] 
]

{ #category : #initalization }
CreateBlockBuilder class >> fromMethod: aCompiledMethod [
^self from: 
	[ :aSelectedValue :aValue | 
		aCompiledMethod  valueWithReceiver: aCompiledMethod methodClass arguments: {aSelectedValue. aValue}
	] 
]

{ #category : #accessing }
CreateBlockBuilder >> block [
	^ block
]

{ #category : #initalization }
CreateBlockBuilder >> block: aBlock [
	block := aBlock.
]

{ #category : #factory }
CreateBlockBuilder >> cull: anObject cull: aModel [
	^ BlockSearchFilter
		block: block
		model: aModel
		selectedValue: anObject
]
