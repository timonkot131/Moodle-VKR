Class {
	#name : #MoodleAvailableFiltersBuilder,
	#superclass : #Object,
	#instVars : [
		'filterItemsModel'
	],
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #'as yet unclassified' }
MoodleAvailableFiltersBuilder >> availableFilters [
<return: #Collection of: #GtFilterModel>
^#()

]

{ #category : #accessing }
MoodleAvailableFiltersBuilder >> filterItemsModel [
	^ filterItemsModel
]

{ #category : #accessing }
MoodleAvailableFiltersBuilder >> filterItemsModel: anObject [
	filterItemsModel := anObject
]
