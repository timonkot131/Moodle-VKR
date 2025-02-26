Class {
	#name : #MoodleEventQuery,
	#superclass : #Object,
	#category : #'MoodleVKR-Model'
}

{ #category : #accessing }
MoodleEventQuery class >> bindMethod: aCollection [
| aSymbol |
	aSymbol := aCollection at -2.
]

{ #category : #accessing }
MoodleEventQuery class >> computeAssociations: arr [
	| data |
	data := arr
		collect: [ :aCollection | 
			| x |
			x := {MoodleQuery} , aCollection.
			x
				at: (x indexOf: x last)
					put: {(x last: 2) first.
							x last};
				yourself ].
	^self flatConnection: data
]

{ #category : #accessing }
MoodleEventQuery class >> flatConnection: arr [
	| elems |
	elems := arr flatten asSet select: #isClass.
	^ elems
		flatCollect: [ :aClass | 
			arr
				select: [ :x | (x indexOf: aClass) ~= 0 ]
				thenCollect: [ :x | 
					| anIndex |
					anIndex := x indexOf: aClass.
					x sliceFrom: anIndex to: anIndex + 1 ] ]
]

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
 {MoodleUser. #email}.
 {MoodleCourse. #fullName}.
 {MoodleCourse. MoodleQuiz. #name}.
 {MoodleCourse. MoodleQuiz. MoodleAttempt. #id}
} 
]
