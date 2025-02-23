Class {
	#name : #MoodleEventQuery,
	#superclass : #Object,
	#category : #'MoodleVKR-Model'
}

{ #category : #rules }
MoodleEventQuery class >> parseRule: anArray [
	| aSplitted |
	aSplitted := (anArray splitOn: ' ') first.
	^ aSplitted
		collect: [ :aValue | 
			| aSymbol |
			aSymbol := aValue asSymbol.
			aSymbol first isUppercase 
				ifTrue: [ aSymbol asClass ] 
				ifFalse: [ aSymbol ] ]
]

{ #category : #'as yet unclassified' }
MoodleEventQuery class >> ruleHierarchy [
"Просто имена для сообщений, описывающие иерархию запроса"
^{
 {#eventname}.
 {MoodleUser. #fullName}.
 {MoodleUser. #enail},
 {MoodleCourse. #fullName}.
 {MoodleCourse. MoodleQuiz. #name}.
 {MoodleCourse. MoodleQuiz. MoodleAttempt. #id}
}
]
