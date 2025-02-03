Class {
	#name : #MoodleAppView,
	#superclass : #BlElement,
	#category : #'MoodleVKR-UI'
}

{ #category : #'as yet unclassified' }
MoodleAppView >> initialize [ 
	super initialize.
]

{ #category : #'as yet unclassified' }
MoodleAppView >> openInSpace [
| aSpace |
	aSpace := BlSpace new
		addChild: self;
		extent: 800@600;
		title: 'Hello World'.
aSpace show
]
