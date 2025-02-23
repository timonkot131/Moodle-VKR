Class {
	#name : #DString,
	#superclass : #Object,
	#instVars : [
		'delegatedMethod'
	],
	#category : #'MoodleVKR-Delegates'
}

{ #category : #'as yet unclassified' }
DString >> accept: aVisitor [
aVisitor visitString: self.

]

{ #category : #accessing }
DString >> delegatedMethod [
	^ delegatedMethod
]

{ #category : #'as yet unclassified' }
DString >> delegatedMethod: aCompiledMethod [
delegatedMethod := aCompiledMethod.
]
