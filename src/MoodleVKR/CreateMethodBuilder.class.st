Class {
	#name : #CreateMethodBuilder,
	#superclass : #Object,
	#instVars : [
		'method'
	],
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #'as yet unclassified' }
CreateMethodBuilder class >> from: aCompiledMethod [
^self new method: aCompiledMethod.
]

{ #category : #'as yet unclassified' }
CreateMethodBuilder >> cull: anObject cull: aModel [
	^ MethodSearchFilter new
		method: method;
		selectedValue: anObject;
		model: aModel
]

{ #category : #'as yet unclassified' }
CreateMethodBuilder >> method: aCompiledMethod [ 
	method := aCompiledMethod
]
