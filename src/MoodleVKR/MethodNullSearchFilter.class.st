Class {
	#name : #MethodNullSearchFilter,
	#superclass : #MethodSearchFilter,
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #testing }
MethodNullSearchFilter >> matches: anObjectOrSymbol [
	^true
]

{ #category : #printing }
MethodNullSearchFilter >> printOn: aStream [ 
aStream << '#pass'.
]
