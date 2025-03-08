Class {
	#name : #MoodleEventQuery,
	#superclass : #Object,
	#category : #'MoodleVKR-Model'
}

{ #category : #accessing }
MoodleEventQuery class >> bindMethod: anArray [
	^ anArray
		at: (anArray indexOf: anArray last)
			put: {(anArray last: 2) first.
					anArray last};
		yourself.
]

{ #category : #accessing }
MoodleEventQuery class >> computeAssociations: arr [
	| data |
	data := self describe: arr.
	data := data
			collect: [ :x | 
				(x sliceFrom: 1 to: x size - 1)
					, {QuerySelector forAssociation: x last sourceClass: self} ].
	^ self flatConnection: data
]

{ #category : #accessing }
MoodleEventQuery class >> computeAssociations: arr forClass: aTMQueryBuilder [
	| data |
	data := self describe: arr.
	data := data
			collect: [ :x | 
				(x sliceFrom: 1 to: x size - 1)
					, {QuerySelector forAssociation: x last sourceClass: aTMQueryBuilder} ].
	^ self flatConnection: data
]

{ #category : #accessing }
MoodleEventQuery class >> describe: arr [
	^ arr
		collect: [ :aCollection | 
			| x |
			x := {MoodleQuery} , aCollection.
			self bindMethod: x ]
]

{ #category : #static }
MoodleEventQuery class >> eventAliases [ 
{
	'ww' -> '21'
}
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

{ #category : #rules }
MoodleEventQuery class >> ruleHierarchy [
"Просто имена для сообщений, описывающие иерархию запроса"
^{
 {#eventname}.
 {#ip}.
 {#timecreated}.
 {MoodleUser. #fullname}.
 {MoodleUser. #username}.
 {MoodleUser. #email}.
 {MoodleCourse. #fullname}.
 {MoodleCourse. #shortname}.
 {MoodleCourse. MoodleQuiz. #name}.
 {MoodleCourse. MoodleQuiz. MoodleAttempt. #id}
} 
]
