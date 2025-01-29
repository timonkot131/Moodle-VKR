Class {
	#name : #BlockSearchFilter,
	#superclass : #GtSearchFilter,
	#instVars : [
		'block',
		'selectedValue',
		'model'
	],
	#category : #'MoodleVKR-Filters - searching'
}

{ #category : #'as yet unclassified' }
BlockSearchFilter class >> block: arg1 model: arg2 selectedValue: arg3 [
	| tmp2 |
	tmp2 := self new.
	tmp2
		block: arg1;
		model: arg2.
	^ tmp2 selectedValue: arg3
]

{ #category : #accessing }
BlockSearchFilter >> block [
	^ block
]

{ #category : #accessing }
BlockSearchFilter >> block: arg1 [
	block := arg1
]

{ #category : #'as yet unclassified' }
BlockSearchFilter >> hash [
	^ block hash
]

{ #category : #'as yet unclassified' }
BlockSearchFilter >> matches: arg1 [
	^ block
		cull: selectedValue
		cull: arg1
		cull: model
]

{ #category : #accessing }
BlockSearchFilter >> model [
	^ model
]

{ #category : #accessing }
BlockSearchFilter >> model: arg1 [
	model := arg1
]

{ #category : #accessing }
BlockSearchFilter >> selectedValue [
	^ selectedValue
]

{ #category : #accessing }
BlockSearchFilter >> selectedValue: arg1 [
	selectedValue := arg1
]
