Class {
	#name : #DisjFilterItemsModel,
	#superclass : #GtFilterItemsModel,
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #'as yet unclassified' }
DisjFilterItemsModel >> asSearchFilter [
	^ self filters reduce: [ :x :y | x | y ]
]

{ #category : #'as yet unclassified' }
DisjFilterItemsModel >> filters [ 
^self items collect: #asSearchFilter
]

{ #category : #'as yet unclassified' }
DisjFilterItemsModel >> initialize [
super initialize.
]
