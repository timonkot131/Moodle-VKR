Class {
	#name : #MoodleQueryTab,
	#superclass : #BrTab,
	#instVars : [
		'mainFrame',
		'queryViewModel',
		'sourceViewModel',
		'titleEditor'
	],
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #'as yet unclassified' }
MoodleQueryTab >> focusTitleEditor [
	titleEditor selection select: 0 to: titleEditor text size.
	titleEditor requestFocus
]

{ #category : #'as yet unclassified' }
MoodleQueryTab >> initialize [ 
	super initialize.
	
	mainFrame := BlElement new 
	padding: (BlInsets all: 10);
	constraintsDo: [:c | 
		c vertical fitContent.
		c horizontal fitContent.
		];
	layout: BlLinearLayout vertical.
	
	titleEditor := BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude new ;
		beEditable;
		vFitContent;
		id: 'Editor';
		geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		 border: (BlBorder paint: Color veryLightGray width: 1).
	titleEditor editor
		 when: BrTextEditorModifiedEvent 
		 do: [:arg | 	
		 	queryViewModel title: arg text asString.
		 	].
		 	
	titleEditor unsubscribe: self.

	mainFrame addChild: titleEditor.
	
	self
		aptitude: BrGlamorousTabAptitude;
		padding: (BlInsets all: 10);
		label: '+ Новый запрос';
		stencil: [ mainFrame ]
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
	self subscribeToQueryViewModel	"Но почему не text:? А потому, что у него потом сбрасывается модель и события не вызываются"
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
	queryViewModel
		when: MoodleQueryTitleChangedEvent
		do: [ :anEvent | 
		
			self label: anEvent title."Но почему не text:? А потому, что у него потом сбрасывается модель и события не вызываются"
			"titleEditor editor replaceWith: anEvent title"]
]

{ #category : #accessing }
MoodleQueryTab >> subscribeToViewModel [
	queryViewModel
		when: MoodleQueryTitleChangedEvent
		do: [ :anEvent | 
			self label: anEvent title.	"Но почему не text:? А потому, что у него потом сбрасывается модель и события не вызываются"
			titleEditor editor replaceWith: anEvent title ]
]
