Class {
	#name : #MQueryHolder,
	#superclass : #BlElement,
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #accessing }
MQueryHolder class >> makeItem: aMoodleQueryViewModel id: anInteger [
	| elem |
	elem := (aMoodleQueryViewModel at: anInteger) isSymbol
			ifTrue: [ MQueryPanelCombine ]
			ifFalse: [ MQueryPanel ].
	^ elem withViewModel: aMoodleQueryViewModel id: anInteger
]

{ #category : #accessing }
MQueryHolder class >> printOn: aBlElement using: aMoodleQueryViewModel [
	| items |
	aBlElement removeChildren.
	items := aMoodleQueryViewModel ids
			collect: [ :id | self makeItem: aMoodleQueryViewModel id: id ].
	^ aBlElement addChildren: items
]
