Class {
	#name : #MoodleQueryColSelect,
	#superclass : #BlElement,
	#instVars : [
		'leftList',
		'rightList',
		'queryViewModel'
	],
	#category : #MoodleVKR
}

{ #category : #accessing }
MoodleQueryColSelect >> changeColumns: aSet [
rightList items: aSet asOrderedCollection.
leftList items: (MoodleEventLog fieldSet difference: aSet) asOrderedCollection.
]

{ #category : #'as yet unclassified' }
MoodleQueryColSelect >> initialize [
super initialize.
"BlFrameLayoutCompositionExamples>>#example"
self
	layout: BlFrameLayout new;
	constraintsDo: [:c |
		c horizontal matchParent .
		c vertical matchParent.
	 ];
	addChildren: {
		leftList := 
			self multiselectList 
				constraintsDo: [:c | c frame horizontal alignLeft].
		BlElement new 
			layout: BlLinearLayout vertical;
			constraintsDo: [:c | 
				c vertical fitContent.
				c horizontal fitContent.
				c frame horizontal alignCenter.
				c frame vertical alignCenter.
			];
			addChildren: {
				self itemMover: '>' action: [
					self queryViewModel addColumns: leftList selectedItems
				].
				(self itemMover: '<' action:[
					self queryViewModel removeColumns: rightList selectedItems
				])
				margin: (BlInsets top: 10)
				.
			}.
		rightList := 
			self multiselectList
				constraintsDo: [:c | c frame horizontal alignRight].
	}
	 
	 

]

{ #category : #'as yet unclassified' }
MoodleQueryColSelect >> itemMover: aString action: aBlock [
	| text |
	text := BlTextElement new
			text: aString asRopedText;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical   alignCenter ];
			defaultFontSize: 20.
	^ BlElement new
		layout: BlFrameLayout new;
		width: 40;
		height: 40;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		border: (BlBorder paint: Color veryVeryLightGray width: 1);
		addChild: text;
		when: BlClickEvent do: aBlock
]

{ #category : #'as yet unclassified' }
MoodleQueryColSelect >> multiselectList [
	^ BrSimpleList new
		constraintsDo: [ :c | c frame vertical alignCenter ];
		width: 200;
		height: 500;
		padding: (BlInsets left: 2);
		border: (BlBorder paint: Color gray width: 1);
		aptitude: BrMultiListAptitude new;
		itemStencil: [ BrLabel new
				aptitude: BrGlamorousLabelAptitude new
						+ (BrStyleCommonAptitude new
								selected: [ :aStyle | aStyle background: Color veryVeryLightGray ]);
				padding: (BlInsets all: 5) ];
		itemDataBinder: [ :eachElement :eachClass :eachIndex | eachElement text: eachClass asRopedText ]
]

{ #category : #accessing }
MoodleQueryColSelect >> onColumnChange: anEvent [
self changeColumns: anEvent columns
]

{ #category : #'as yet unclassified' }
MoodleQueryColSelect >> openInSpace [
| aSpace |
	aSpace := BlSpace new
			addChild: self;
			extent: 800 @ 600;
			title: 'Выбрать колонки'.
	aSpace show
]

{ #category : #accessing }
MoodleQueryColSelect >> queryViewModel [
	^ queryViewModel
]

{ #category : #accessing }
MoodleQueryColSelect >> queryViewModel: anObject [
	queryViewModel := anObject.
	
	self changeColumns: queryViewModel columnSet.
	
	queryViewModel weak 
		when: MoodleQueryColumnChanged
		send: #onColumnChange:
		to: self
]
