Class {
	#name : #MSearchIntersectionFilter,
	#superclass : #GtSearchIntersectionFilter,
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #'as yet unclassified' }
MSearchIntersectionFilter >> & aFilter [
	^ MSearchIntersectionFilter forFilter: self filter: aFilter
]

{ #category : #'as yet unclassified' }
MSearchIntersectionFilter >> matches: anObject [
	^ (left matches: anObject) & (right matches: anObject)
]

{ #category : #'as yet unclassified' }
MSearchIntersectionFilter >> | aFilter [
	^ MSearchUnionFilter forFilter: self filter: aFilter
]
