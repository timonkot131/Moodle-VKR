Class {
	#name : #MQueryPanel,
	#superclass : #BlElement,
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #'instance creation' }
MQueryPanel class >> newToggle: aString id: anIdString [
	| radio |
	radio := BrCheckbox new
			margin: (BlInsets left: 6);
			aptitude: BrGlamorousCheckboxAptitude;
			disable;
			when: BlClickEvent 
			do: [:x | 
				x target class = BrCheckbox ifTrue:
				 [x target parent activate]
			].
	^BrToggle new
		id: anIdString;
		aptitude: BrMaterialToggleLabelledAptitude;
		margin: (BlInsets left: 5);
		label: aString;
		when: BrToggleActivatedEvent
			do: [ :anEvent | radio check];
		when: BrToggleDeactivatedEvent
			do: [ :anEvent | radio uncheck ];
		addChild: radio;
		deactivate
]

{ #category : #'instace creation' }
MQueryPanel class >> removeButton: aQueryViewModel id: anInteger [
	^BrButton new
			constraintsDo: [ :c | c linear vertical alignCenter ];
			aptitude: BrGlamorousButtonWithLabelAptitude new;
			action: [ aQueryViewModel remove: anInteger ];
			label: 'Убрать';
			margin: (BlInsets left: 6);
			beLargeSize.
]

{ #category : #initialization }
MQueryPanel class >> withViewModel: aQueryViewModel id: anInteger [
	| instance button toggleOr toggleAnd toggleGroup model filterView |
	toggleOr := self newToggle: 'Или' id: 'or'.
	toggleAnd := self newToggle: 'И' id: 'and'.
	model := aQueryViewModel at: anInteger.
	
	self assert: (model isKindOf: GtFilterItemsModel).
	model class = ConjFilterItemsModel ifTrue: [ toggleAnd activate ].
	model class = DisjFilterItemsModel ifTrue: [ toggleOr activate ].
		
	filterView := model asFiltersElement margin: (BlInsets top: 5).
	
	model weak 
			when: GtFiltersModelUpdated 
			do: [aQueryViewModel getItems ].
	
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
								put: (ConjFilterItemsModel new 
									items: model items;
									availableFiltersBuilder: model availableFiltersBuilder) ]
						ifFalse: [ aQueryViewModel
								at: anInteger
								put: (DisjFilterItemsModel new
								 	items: model items;
								 	availableFiltersBuilder: model availableFiltersBuilder) ] ].

	instance := self new.
	button := self removeButton: aQueryViewModel id: anInteger .
	instance addChildren: {filterView. toggleAnd. toggleOr}.
	aQueryViewModel isSingle ifTrue: [ instance addChild: button ].
	^ instance
]

{ #category : #'as yet unclassified' }
MQueryPanel >> initialize [
	super initialize.
	self
		layout: BlLinearLayout horizontal;
		padding: (BlInsets top: 1 bottom: 1);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ]
]
