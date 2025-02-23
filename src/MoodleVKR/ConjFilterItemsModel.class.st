Class {
	#name : #ConjFilterItemsModel,
	#superclass : #GtFilterItemsModel,
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #'as yet unclassified' }
ConjFilterItemsModel >> asSearchFilter [
	^ self filters reduce: [ :x :y | x & y ]
]

{ #category : #'as yet unclassified' }
ConjFilterItemsModel >> filters [ 
^self items collect: #asSearchFilter
]

{ #category : #'as yet unclassified' }
ConjFilterItemsModel >> initialize [
super initialize.
]
