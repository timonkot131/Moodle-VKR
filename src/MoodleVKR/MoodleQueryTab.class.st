Class {
	#name : #MoodleQueryTab,
	#superclass : #BlElement,
	#instVars : [
		'queryViewModel',
		'titleEditor',
		'filterView',
		'phlowLogElement',
		'phlowView',
		'errorText',
		'errorWrapper'
	],
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #'as yet unclassified' }
MoodleQueryTab class >> actionbarStencil: aBlock [
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
					action: [ aBlock value ]} ]
]

{ #category : #'as yet unclassified' }
MoodleQueryTab class >> fieldColumns [
	^ {'Событие'
			-> {#name -> 'Событие'.
					#priority -> 10.
					#calc -> [ :each | each eventName ].
					#width -> 240}.
		'IP'
			-> {#name -> 'IP'.
					#priority -> 20.
					#width -> 120.
					#calc -> [ :each | each ip ]}.
		'Дата'
			-> {#name -> 'Дата'.
					#priority -> 19.
					#width -> 90.
					#calc -> [ :each | MLogDate ofUnixToString: each timeCreated ]}.
		'Время'
			-> {#name -> 'Время'.
					#priority -> 18.
					#width -> 45.
					#calc -> [ :each | MLogTime ofUnixToString: each timeCreated ]}.
		'Уровень'
			-> {#name -> 'Уровень'.
					#priority -> 21.
					#width -> 60.
					#calc
						-> [ :each | MoodleEventQuery contextLevels keyAtValue: each contextLevel ]}.
		'Пользователь'
			-> {#name -> 'Пользователь'.
					#priority -> 30.
					#width -> 80.
					#calc -> [ :each | each user userName ]}.
		'Авторизация'
			-> {#name -> 'Авторизация'.
					#priority -> 31.
					#width -> 60.
					#calc -> [ :each | each user auth ]}.
		'Имя'
			-> {#name -> 'Имя'.
					#priority -> 32.
					#width -> 90.
					#calc -> [ :each | each user firstName ]}.
		'Фамилия'
			-> {#name -> 'Фамилия'.
					#priority -> 33.
					#width -> 90.
					#calc -> [ :each | each user lastName ]}.
		'Полное имя'
			-> {#name -> 'Полное имя'.
					#priority -> 34.
					#width -> 130.
					#calc -> [ :each | each user fullName ]}.
		'Почта'
			-> {#name -> 'Почта'.
					#priority -> 35.
					#width -> 80.
					#calc -> [ :each | each user email ]}.
		'Связанный пользователь'
			-> {#name -> 'Связанный Пользователь'.
					#priority -> 36.
					#width -> 80.
					#calc -> [ :each | each relatedUser ifNotNil: #userName ifNil: [ 'Нет' ] ]}.
		'Связанная авторизация'
			-> {#name -> 'Связанная Авторизация'.
					#priority -> 37.
					#width -> 60.
					#calc -> [ :each | each relatedUser ifNotNil: #auth ifNil: 'Нет' ]}.
		'Связанное имя'
			-> {#name -> 'Связанное Имя'.
					#priority -> 38.
					#width -> 90.
					#calc
						-> [ :each | each relatedUser ifNotNil: #firstName ifNil: [ 'Нет' ] ]}.
		'Связанная фамилия'
			-> {#name -> 'Связанная Фамилия'.
					#priority -> 39.
					#width -> 90.
					#calc
						-> [ :each | each relatedUser ifNotNil: #lastName ifNil: [ 'Нет' ] ]}.
		'Связанное полное имя'
			-> {#name -> 'Связанное Полное имя'.
					#priority -> 40.
					#width -> 130.
					#calc
						-> [ :each | each relatedUser ifNotNil: #fullName ifNil: [ 'Нет' ] ]}.
		'Связанная почта'
			-> {#name -> 'Связанная Почта'.
					#priority -> 41.
					#width -> 80.
					#calc -> [ :each | each relatedUser ifNotNil: #email ifNil: [ 'Нет' ] ]}.
		'Полное название курса'
			-> {#name -> 'Полное название курса'.
					#priority -> 50.
					#width -> 130.
					#calc -> [ :each | each course ifNotNil: #fullName ifNil: [ 'Нет' ] ]}.
		'Курс'
			-> {#name -> 'Курс'.
					#priority -> 51.
					#width -> 90.
					#calc
						-> [ :each | each course ifNotNil: [ :x | x shortname ] ifNil: [ 'Нет' ] ]}.
		'Категория курса'
			-> {#name -> 'Категория курса'.
					#priority -> 52.
					#width -> 100.
					#calc
						-> [ :each | each course ifNotNil: [ :x | x category ] ifNil: [ 'Нет' ] ]}}
		asDictionary
]

{ #category : #'as yet unclassified' }
MoodleQueryTab >> focusTitleEditor [
	titleEditor selection select: 0 to: titleEditor text size.
	titleEditor requestFocus
]

{ #category : #'as yet unclassified' }
MoodleQueryTab >> initialize [
	| controlPanel |
	super initialize.
	
	self
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

	
	controlPanel := 
		BlElement new 
			layout: BlLinearLayout horizontal;
			constraintsDo: [:c |
				c horizontal matchParent.
				c vertical fitContent.
			];
			addChildren: {
				BrButton new
					aptitude: BrGlamorousButtonWithLabelAptitude new;
					action: [ self queryViewModel addQuery ];
					margin: (BlInsets top: 10);
					label: 'Добавить запрос';
					beLargeSize.
				BrButton new
					aptitude: BrGlamorousButtonWithLabelAptitude new;
					action: [ 
						MoodleQueryColSelect new queryViewModel: self queryViewModel; openInSpace  ];
					margin: (BlInsets top: 10 left: 5);
					label: 'Выбрать колонки';
					beLargeSize.}.
		
	filterView := BlElement new layout: BlLinearLayout vertical;
		margin: (BlInsets top: 6);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical fitContent.
				].
	
	phlowView := self phlowView.
	phlowLogElement := phlowView asElement height: 340.
	phlowLogElement childNamed: 'label'
		ifFound: [:child | child text: 'Результаты запроса' asRopedText ]
		ifNone: [].

	self addChild: titleEditor.
	self addChild: controlPanel.
	self addChild: filterView.
	self addChild: phlowLogElement.
]

{ #category : #accessing }
MoodleQueryTab >> onCancel: anObject [
	| reason |
	reason := anObject reason.
	(reason isKindOf: Error) ifFalse: [ ^ self ].
	GtJustContextStackSignal emit.
	self
		childNamed: 'errorwrap'
		ifFound: [  ]
		ifNone: [ self addChild: errorWrapper at: 2 ].
	errorText text: (reason messageText asRopedText foreground: Color red)
]

{ #category : #'as yet unclassified' }
MoodleQueryTab >> onFilterUpdate: anAnnouncement [
	self removeChildNamed: 'errorwrap';
		 removeChild: phlowLogElement.
	phlowView := self phlowView items: [ anAnnouncement items filter: #isNotNil ].
	phlowLogElement := phlowView asElement height: 340.
	self addChild: phlowLogElement.
]

{ #category : #'event - handling' }
MoodleQueryTab >> onPanelUpdate: _ [
MQueryHolder printOn: filterView using: self queryViewModel.

]

{ #category : #'event - handling' }
MoodleQueryTab >> onTitleChanged: anEvent [
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
	| phlow columns |
	phlow := GtPhlowView empty columnedList
			title: 'Результаты запросов';
			priority: 5;
			contextItemLabel: 'Тепловая карта'
				action: [ :element :item | 
					| aSpace |
					aSpace := BlSpace new
							extent: 800 @ 500;
							title: 'Moodle app';
							withSceneDriller;
							addChild: (CalendarPager forEventLog: item);
							show ].


	columns := self queryViewModel
			ifNil: [ #() ]
			ifNotNil: [ :x |
				x columnSet collect: [ :each |
				 	(self class fieldColumns at: each) 
				 	asDictionary ] ].
	columns := columns sorted: [ :each | each at: #priority ] ascending.
	columns
		do: [ :each | 
			| name text width |
			name := each at: #name.
			text := each at: #calc.
			width := each at: #width.
			phlow
				column: name
				text: text
				width: width ].
	^ phlow
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
	
	MQueryHolder printOn: filterView using: queryViewModel.
	titleEditor editor replaceWith: aQueryViewModel title.
	self subscribeToQueryViewModel.
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
