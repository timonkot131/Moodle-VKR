Class {
	#name : #MoodleQueryHorizontalTree,
	#superclass : #GtGradHorizontalTreeLayout,
	#instVars : [
		'breadth',
		'offsetBreadth'
	],
	#category : #'MoodleVKR-Utility'
}

{ #category : #'as yet unclassified' }
MoodleQueryHorizontalTree >> nodeBreadth: aTreeNode [
	^(super nodeBreadth: aTreeNode) * breadth
]

{ #category : #'as yet unclassified' }
MoodleQueryHorizontalTree >> nodeOffsetBreadth: aTreeNode [
	^(super nodeOffsetBreadth: aTreeNode) * offsetBreadth.
]

{ #category : #'as yet unclassified' }
MoodleQueryHorizontalTree >> scaleBreadth: aNumber [ 
	breadth := aNumber
]

{ #category : #'as yet unclassified' }
MoodleQueryHorizontalTree >> scaleBreadthOffset: aNumber [
	offsetBreadth := aNumber
]
