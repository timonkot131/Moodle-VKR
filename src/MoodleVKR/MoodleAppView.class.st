Class {
	#name : #MoodleAppView,
	#superclass : #BlElement,
	#instVars : [
		'viewModel'
	],
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #'as yet unclassified' }
MoodleAppView >> appViewModel [ 
^viewModel
]

{ #category : #'as yet unclassified' }
MoodleAppView >> appViewModel: aViewModel [
	viewModel == aViewModel ifTrue: [^self].
	viewModel ifNotNil: [
		viewModel unsubscribe: self.
	].
	viewModel := aViewModel. 

self subscribeToViewModel.
]

{ #category : #'as yet unclassified' }
MoodleAppView >> initialize [
	| aTabGroup |
	super initialize.
	aTabGroup := BrTabGroup new
		aptitude: BrGlamorousTabGroupAptitude;
		size: 400 @ 300;
	    border: (BlBorder paint: Color lightGray width: 1);
	    addTab: (MoodleDbTab new magritteViewModel: MySQLDriverSpec new asGtMagritteViewModel).
	    
	self layout: BlFrameLayout new;
	constraintsDo: [:c | 
		c vertical fitContent .
		c horizontal fitContent.];
	addChild: aTabGroup
]

{ #category : #'as yet unclassified' }
MoodleAppView >> openInSpace [
| aSpace |
	aSpace := BlSpace new
		addChild: self;
		extent: 800@600;
		title: 'Moodle app'.
aSpace show
]

{ #category : #'as yet unclassified' }
MoodleAppView >> subscribeToViewModel [
	self viewModel weak
	when: MoodleAppEvent do: [:arg | arg traceCr]
]
