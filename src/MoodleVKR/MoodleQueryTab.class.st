Class {
	#name : #MoodleQueryTab,
	#superclass : #BrTab,
	#instVars : [
		'mainFrame',
		'queryViewModel',
		'sourceViewModel',
		'titleEditor',
		'titleHandler',
		'availableFilters',
		'anItemsModelType',
		'anItemsModel',
		'filterView',
		'phlowLogElement',
		'phlowView',
		'errorText',
		'errorWrapper'
	],
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #'as yet unclassified' }
MoodleQueryTab >> actionbarStencil [
	^ [ :aTabModel | 
	BrToolbar new
		aptitude: (BrGlamorousToolbarAptitude new spacing: 0);
		margin: (BlInsets left: 6);
		addItems: {BrButton new
					icon: BrGlamorousVectorIcons close;
					exact: 16 @ 16;
					aptitude: GtWorldTabToolbarButtonAptitude;
					label: 'Close';
					model: aTabModel;
					containerName: #CloseTab;
					action: [ self removeFromToolbar ]} ]
]

{ #category : #'as yet unclassified' }
MoodleQueryTab >> focusTitleEditor [
	titleEditor selection select: 0 to: titleEditor text size.
	titleEditor requestFocus
]

{ #category : #'as yet unclassified' }
MoodleQueryTab >> initialize [
	| addButton |
	super initialize.
	
	mainFrame := BlElement new
			padding: (BlInsets all: 10);
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal matchParent ];
			layout: BlLinearLayout vertical.

	titleEditor := BrEditor new
			aptitude: BrGlamorousRegularEditorAptitude new;
			beEditable;
			vFitContent;
			id: 'Editor';
			geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
			border: (BlBorder paint: Color veryLightGray width: 1).

	titleEditor editor
		when: BrTextEditorModifiedEvent
		do: self onTitleEditorChanged.
		
	errorText := BlTextElement new
			constraintsDo: [ :c | c frame horizontal alignLeft ];
			id: #errortext.
			 
	errorWrapper := BlElement new
		id: #errorwrap;
		layout: BlFrameLayout new;
		height: 40;
		padding: (BlInsets top:14);
		constraintsDo: [ :c | c horizontal matchParent ];
		addChild: errorText.

	addButton := BrButton new
					aptitude: BrGlamorousButtonWithLabelAptitude new;
					action: [ self queryViewModel addQuery ];
					margin: (BlInsets top: 10);
					label: 'Добавить запрос';
					beLargeSize.
		
	filterView := BlElement new layout: BlLinearLayout vertical;
		margin: (BlInsets top: 6);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical fitContent.
				].
	
	phlowView := self phlowView.
	phlowLogElement := phlowView asElement height: 340.

	mainFrame addChild: titleEditor.
	mainFrame addChild: addButton.
	mainFrame addChild: filterView.
	mainFrame addChild: phlowLogElement.

	self
		aptitude: BrGlamorousTabAptitude;
		padding: (BlInsets all: 10);
		label: '+ Новый запрос';
		stencil: [ mainFrame ]
]

{ #category : #accessing }
MoodleQueryTab >> onCancel: anObject [
	| reason |
	reason := anObject reason.
	(reason isKindOf: Error) ifFalse: [ ^ self ].
	mainFrame
		childNamed: 'errorwrap'
		ifFound: [  ]
		ifNone: [ mainFrame addChild: errorWrapper at: 2 ].
	errorText text: (reason messageText asRopedText foreground: Color red)
]

{ #category : #'as yet unclassified' }
MoodleQueryTab >> onFilterUpdate: anAnnouncement [
	mainFrame removeChildNamed: 'errorwrap'.
	phlowView items: [ anAnnouncement items ].
	phlowLogElement phlow update
]

{ #category : #'event - handling' }
MoodleQueryTab >> onPanelUpdate: _ [
MQueryHolder printOn: filterView using: self queryViewModel.

]

{ #category : #'event - handling' }
MoodleQueryTab >> onTitleChanged: anEvent [
	self label: anEvent title.	"Мне нужно убедиться, что он не тригерит сам себя"
	^ titleEditor editor
		removeEvent: BrTextEditorModifiedEvent;
		replaceWith: anEvent title;
		when: BrTextEditorModifiedEvent do: self onTitleEditorChanged
]

{ #category : #'as yet unclassified' }
MoodleQueryTab >> onTitleEditorChanged [
	^ [ :anEvent | queryViewModel title: anEvent text asString ]
]

{ #category : #'as yet unclassified' }
MoodleQueryTab >> phlowView [
	^ GtPhlowView empty columnedList
		title: 'Items';
		priority: 5;
		column: 'Событие' text: [ :each | each eventName ];
		column: 'Уровень' text: [ :each |
			MoodleEventQuery contextLevels keyAtValue: each contextLevel ]
			width: 60;
		column: 'Пользователь'
			text: [ :each | each user userName ]
			width: 70;
		column: 'Курс'
			text: [ :each | each course ifNotNil: [ :x | x shortname ] ifNil: [ 'Нет' ] ]
			width: 70;
	 column: 'Дата' text: [ :each | MLogDate ofUnixToString: each timeCreated] width: 60;
		column: 'Время' text: [ :each | MLogTime ofUnixToString: each timeCreated] width: 50.
]

{ #category : #accessing }
MoodleQueryTab >> queryViewModel [
	^ queryViewModel
]

{ #category : #accessing }
MoodleQueryTab >> queryViewModel: aQueryViewModel [
	queryViewModel == aQueryViewModel ifTrue: [ ^ self ].
	queryViewModel ifNotNil: [ queryViewModel unsubscribe: self ].
	queryViewModel := aQueryViewModel.
	
	self viewModel actionbarStencilBuilder ifNil: [ 
		self actionbarStencil: self actionbarStencil
	].
	
	MQueryHolder printOn: filterView using: queryViewModel.
	
	self subscribeToQueryViewModel.
]

{ #category : #'as yet unclassified' }
MoodleQueryTab >> removeFromToolbar [
	self parentTabGroup
		selectTabToTheLeft;
		removeTab: self.

	self sourceViewModel unsubscribe: self queryViewModel.
	self queryViewModel unsubscribe: self
]

{ #category : #accessing }
MoodleQueryTab >> sourceViewModel [
	^ sourceViewModel
]

{ #category : #'as yet unclassified' }
MoodleQueryTab >> sourceViewModel: aMoodleSourceViewModel [
	queryViewModel
		ifNil: [ Exception signal: 'queryViewModel должна быть инициализирована' ].
	sourceViewModel == aMoodleSourceViewModel ifTrue: [ ^ self ].
	sourceViewModel ifNotNil: [ sourceViewModel unsubscribe: queryViewModel ].
	sourceViewModel := aMoodleSourceViewModel.

	sourceViewModel 
		when: MoodleModelChanged 
		send: #onModelChanged:
		to: self queryViewModel
		for: self queryViewModel.
]

{ #category : #accessing }
MoodleQueryTab >> subscribeToQueryViewModel [
	(queryViewModel weak)
		when: MoodleQueryTitleChangedEvent
			send: #onTitleChanged:
			to: self;
		when: MoodleQueryValueChanged
			send: #onFilterUpdate:
			to: self;
		when: MoodleQueryModelChanged
			send: #onPanelUpdate:
			to: self;
		when: MoodleCancelEvent
			send: #onCancel:
			to: self.
]

{ #category : #accessing }
MoodleQueryTab >> subscribeToViewModel [
	queryViewModel
		when: MoodleQueryTitleChangedEvent
		do: [ :anEvent | 
			self label: anEvent title.	"Но почему не text:? А потому, что у него потом сбрасывается модель и события не вызываются"
			titleEditor editor replaceWith: anEvent title ]
]
