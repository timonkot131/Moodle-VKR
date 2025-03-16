Class {
	#name : #MEventCompletionStrategy,
	#superclass : #GtStreamedCompletionStrategy,
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #completing }
MEventCompletionStrategy >> completionActionStreamFor: aText at: positionInteger requested: isRequested [
	| aT |
	^ (super
		completionActionStreamFor: aText
		at: positionInteger
		requested: isRequested)
		collect: [ :x | 
			aT := GtReplaceSubtextCompletionAction new
				start: 0;
				end: aText size ;
				label: x label;
				text: x label.
			Smalltalk at: #debug put: aT.
			aT ]
]

{ #category : #completing }
MEventCompletionStrategy >> completionStringStreamStartingWith: aPrefixString [
	"Please note, that a prefix string can be empty"
	aPrefixString isEmpty ifTrue: [ 
		^#() asAsyncStream
	].
	
	^MoodleEventQuery events asAsyncStream select: [:x | x includesSubstring: aPrefixString].
]
