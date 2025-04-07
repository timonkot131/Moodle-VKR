Class {
	#name : #CalendarDay,
	#superclass : #Object,
	#instVars : [
		'day',
		'month',
		'year'
	],
	#category : #'MoodleVKR-Utility'
}

{ #category : #'as yet unclassified' }
CalendarDay >> asDateAndTime [
^DateAndTime year: year month: month day: day
]

{ #category : #'as yet unclassified' }
CalendarDay >> day [ ^day
]

{ #category : #accessing }
CalendarDay >> day: anInteger [
day := anInteger
]

{ #category : #'as yet unclassified' }
CalendarDay >> month [
	^ month
]

{ #category : #accessing }
CalendarDay >> month: anInteger [
month := anInteger
]

{ #category : #accessing }
CalendarDay >> year [
	^ year
]

{ #category : #accessing }
CalendarDay >> year: anInteger [
	year := anInteger
]
