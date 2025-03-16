Class {
	#name : #MoodleAvailableFiltersBuilder,
	#superclass : #Object,
	#traits : 'TMQueryBuilder',
	#classTraits : 'TMQueryBuilder classTrait',
	#instVars : [
		'filterItemsModel'
	],
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleCourseShortname: aCompiledMethod [
<rule: #(MoodleCourse shortname)>
^GtFilterTextModel new 
	name: 'Курс: Короткое имя'
	
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleQueryEventname: aCompiledMethod [
<rule: #(eventname)>
^GtFilterTextModel new 
	name: 'Событие'.
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleUserUsername: aCompiledMethod [
<rule: #(MoodleUser username)>
^GtFilterTextModel new 
	name: 'Пользователь: Ник'
]

{ #category : #'as yet unclassified' }
MoodleAvailableFiltersBuilder class >> queryMethodSelector: selector class: class [ 
^(class first asLowercase asString, class copyWithoutFirst)
			, (selector first asUppercase asString, selector copyWithoutFirst)
			, ': aCompiledMethod' .
]

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
