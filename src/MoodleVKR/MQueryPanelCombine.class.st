Class {
	#name : #MQueryPanelCombine,
	#superclass : #BlElement,
	#instVars : [
		'combine'
	],
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #'as yet unclassified' }
MQueryPanelCombine class >> withViewModel: aQueryViewModel id: anInteger [
	| instance toggleOr toggleAnd toggleGroup model |
	toggleOr := MQueryPanel newToggle: 'Или' id: 'or'.
	toggleAnd := MQueryPanel newToggle: 'И' id: 'and'.
	model := aQueryViewModel at: anInteger.
	
	model = #& ifTrue: [ toggleAnd activate ].
	model = #| ifTrue: [ toggleOr activate ].
	
	toggleGroup := BrToggleGroupModel new
			addToggle: toggleOr viewModel;
			addToggle: toggleAnd viewModel;
			when: BrToggleActivatedEvent
				do: [ :anEvent | 
					| id |
					id := anEvent currentTarget activatedToggle widget id asSymbol.
					id = #and
						ifTrue: [ aQueryViewModel
								at: anInteger
								put: #& ]
						ifFalse: [ aQueryViewModel
								at: anInteger
								put: #| ] ].

	instance := self new.
	instance addChildren: {toggleAnd. toggleOr}.
	^ instance
]

{ #category : #'as yet unclassified' }
MQueryPanelCombine >> initialize [
	super initialize.
	self
		layout: BlLinearLayout horizontal;
		padding: (BlInsets top: 1 bottom: 1);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ]
]
