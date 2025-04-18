Class {
	#name : #MoodleAppView,
	#superclass : #BlElement,
	#instVars : [
		'viewModel',
		'aTabGroup'
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
	| magritteViewModel dbTab queryTab |
	super initialize.

	magritteViewModel := GtMagritteViewModel forMyObject: MySQLDriverSpec new.
	self appViewModel: MoodleSourceViewModel new.

	dbTab := MoodleDbTab new
			magritteViewModel: magritteViewModel;
			sourceViewModel: self appViewModel.
			
	queryTab := self newTab.
	queryTab userData 
		at: #tabType put: MoodleQueryTab new.
	queryTab stencil: [queryTab userData at: #tabType].

	aTabGroup := BrTabGroup new
			aptitude: BrGlamorousTabGroupAptitude;
			constraintsDo: [ :c | 
				c vertical matchParent.
				c horizontal matchParent ];
			border: (BlBorder paint: Color lightGray width: 1);
			addTabs: {dbTab.
					queryTab}.

	aTabGroup
		when: BrTabSelectedEvent
		do: [ :anEvent | self onQueryTabClick: anEvent ].

	self
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		addChild: aTabGroup
]

{ #category : #'as yet unclassified' }
MoodleAppView >> newTab [
	^ BrTab new
		aptitude: BrGlamorousTabAptitude;
		padding: (BlInsets all: 10);
		label: '+ Новый запрос'
]

{ #category : #'as yet unclassified' }
MoodleAppView >> onQueryTabClick: anEvent [
	| tab queryViewModel newQueryTab tabType |
	tab := anEvent tab widget.
	tabType := tab userData at: #tabType ifAbsent: [ ^self ].
	tabType queryViewModel ifNotNil: [ ^ self ].
	queryViewModel := MoodleQueryViewModel new.
	
	queryViewModel 
		when: MoodleQueryTitleChangedEvent
		do: [:x | tab label: x title ].
	
	tab viewModel actionbarStencilBuilder ifNil: [ 
		tab actionbarStencil: ( MoodleQueryTab
			actionbarStencil: [
				tab parentTabGroup 
					selectTabToTheLeft;
					removeTab: tab
			])
	].
	tabType
		queryViewModel: queryViewModel.
	queryViewModel title: 'Новый запрос'.
	tabType focusTitleEditor.
	newQueryTab := self newTab.
	newQueryTab userData 
		at: #tabType put: MoodleQueryTab new.
	newQueryTab stencil: [newQueryTab userData at: #tabType].
	aTabGroup addTab: newQueryTab.
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
]
