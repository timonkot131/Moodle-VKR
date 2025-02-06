Class {
	#name : #MoodleAppView,
	#superclass : #BlElement,
	#instVars : [
		'viewModel'
	],
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #'as yet unclassified' }
MoodleAppView >> initialize [
	| aTabGroup |
	super initialize.
	aTabGroup := BrTabGroup new.
	aTabGroup
		aptitude: BrGlamorousTabGroupAptitude + 
		(BrMaterialRoundedAptitude new cornerRadius: 20).
	aTabGroup size: 150 @ 150.
	aTabGroup border: (BlBorder paint: Color lightGray width: 1).
	self layout: BlFrameLayout new
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

{ #category : #'as yet unclassified' }
MoodleAppView >> viewModel [ 
^viewModel
]

{ #category : #'as yet unclassified' }
MoodleAppView >> viewModel: aViewModel [
	viewModel == aViewModel ifTrue: [^self].
	viewModel ifNotNil: [
		viewModel unsubscribe: self.
	].
	viewModel := aViewModel. 

self subscribeToViewModel.
]
