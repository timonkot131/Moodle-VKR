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

	queryTab := MoodleQueryTab new.

	aTabGroup := BrTabGroup new
			aptitude: BrGlamorousTabGroupAptitude;
			constraintsDo: [:c | c vertical matchParent.
									c horizontal matchParent];
	
			border: (BlBorder paint: Color lightGray width: 1);
			addTabs: {dbTab.
					queryTab}.

	aTabGroup
		when: BrTabSelectedEvent
		do: [:anEvent | 
		self onQueryTabClick: anEvent].

	self
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		addChild: aTabGroup
]

{ #category : #'as yet unclassified' }
MoodleAppView >> onQueryTabClick: anEvent [
	| tab queryViewModel newQueryTab |
	tab := anEvent tab widget.
	(tab isKindOf: MoodleQueryTab) ifFalse: [ ^self ].
	tab queryViewModel ifNotNil: [ ^ self ].
	queryViewModel := MoodleQueryViewModel new.
	tab
		queryViewModel: queryViewModel;
		sourceViewModel: self appViewModel.	"Сначала Должна произойти подписка, напимер подписка на изменение названия вкладки"
	queryViewModel title: 'Новый запрос'.
	tab focusTitleEditor.
	newQueryTab := MoodleQueryTab new.
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
