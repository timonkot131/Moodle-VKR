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
			size: 400 @ 300;
			border: (BlBorder paint: Color lightGray width: 1);
			addTabs: {dbTab.
					queryTab}.

	aTabGroup
		when: BrTabSelectedEvent
		do: [:anEvent | self onQueryTabClick: anEvent].

	self
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ];
		addChild: aTabGroup
]

{ #category : #'as yet unclassified' }
MoodleAppView >> onQueryTabClick: anEvent [
	| tab queryViewModel queryTab |
	tab := anEvent tab widget.
	(tab isKindOf: MoodleQueryTab) ifFalse: [ ^self ].
	tab queryViewModel ifNotNil: [ ^ self ].
	queryViewModel := MoodleQueryViewModel new.
	tab
		queryViewModel: queryViewModel;
		sourceViewModel: self appViewModel.	"Сначала Должна произойти подписка, напимер подписка на изменение названия вкладки"
	queryViewModel title: 'Новый запрос'.
	queryTab := MoodleQueryTab new.
	aTabGroup addTab: queryTab.
				
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
