Class {
	#name : #BlockSearchFilter,
	#superclass : #GtSearchFilter,
	#instVars : [
		'block',
		'selectedValue',
		'model'
	],
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #'as yet unclassified' }
BlockSearchFilter class >> block: aBlock model: aModel selectedValue: anObject [
	^self new
		block: aBlock;
		model: aModel;
	    selectedValue: anObject.
]

{ #category : #'logical operations' }
BlockSearchFilter >> & aFilter [
	^ MSearchIntersectionFilter forFilter: self filter: aFilter
]

{ #category : #accessing }
BlockSearchFilter >> block [
	^ block
]

{ #category : #accessing }
BlockSearchFilter >> block: aBlock [
	block := aBlock
]

{ #category : #'as yet unclassified' }
BlockSearchFilter >> hash [
	^ block hash
]

{ #category : #'as yet unclassified' }
BlockSearchFilter >> matches: anObject [
	^ block
		cull: selectedValue
		cull: anObject
		cull: model
]

{ #category : #accessing }
BlockSearchFilter >> model [
	^ model
]

{ #category : #accessing }
BlockSearchFilter >> model: anObject [
	model := anObject
]

{ #category : #accessing }
BlockSearchFilter >> selectedValue [
	^ selectedValue
]

{ #category : #accessing }
BlockSearchFilter >> selectedValue: anObject [
	selectedValue := anObject
]

{ #category : #'logical operations' }
BlockSearchFilter >> | aFilter [
	^ MSearchUnionFilter forFilter: self filter: aFilter
]
