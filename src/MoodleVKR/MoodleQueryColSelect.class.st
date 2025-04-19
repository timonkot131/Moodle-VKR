Class {
	#name : #MoodleQueryColSelect,
	#superclass : #BlElement,
	#category : #MoodleVKR
}

{ #category : #'as yet unclassified' }
MoodleQueryColSelect >> initialize [
| leftList rightList |
super initialize.
"BlFrameLayoutCompositionExamples>>#example"
self
	layout: BlFrameLayout new;
	constraintsDo: [:c |
		c horizontal matchParent .
		c vertical matchParent.
	 ];
	addChildren: {
		BlElement new 
			layout: BlLinearLayout vertical;
			constraintsDo: [:c | 
				c vertical fitContent.
				c horizontal fitContent.
				c frame horizontal alignCenter.
				c frame vertical alignCenter.
			];
			addChildren: {
				self itemMover: '>' action: [].
				(self itemMover: '<' action: [])
				margin: (BlInsets top: 10)
				.
			}.
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
		itemStencil: [
			BrLabel new
				"hMatchParent;"
				aptitude: BrGlamorousLabelAptitude new + (BrStyleCommonAptitude new
					selected: [ :aStyle | aStyle background: Color veryVeryLightGray ]);
				padding: (BlInsets all: 5) ];
		itemDataBinder: [ :eachElement :eachClass :eachIndex | eachElement text: eachClass name ];
		aptitude: BrMultiListAptitude new.
		
]
