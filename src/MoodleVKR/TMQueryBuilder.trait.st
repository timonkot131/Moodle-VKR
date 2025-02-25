Trait {
	#name : #TMQueryBuilder,
	#category : #'MoodleVKR-Model'
}

{ #category : #accessing }
TMQueryBuilder classSide >> createGraph [
	| mainRules view selfRules extraRules allRules |
	mainRules := MoodleEventQuery computeAssociations: MoodleEventQuery ruleHierarchy.
	selfRules := MoodleEventQuery computeAssociations: self rules keys.
	extraRules := selfRules difference: mainRules.
	allRules := mainRules, extraRules.
	view := GtMondrian new.
	view nodes
		stencil: [ :x |  
			| textElement textAligned  circle text res |
			circle := BlElement new
					border: (BlBorder paint: Color black width: 1);
					geometry: BlEllipseGeometry new;
					padding: (BlInsets all: 5);
					size: 10 @ 10.

			text := x isArray ifTrue: [ x second ] ifFalse: x.

			textElement := (BlTextElement
					text: (text asRopedText
							foreground: Color black;
							fontSize: 3))
								constraintsDo: [ :c | c frame horizontal alignCenter ].

			textAligned := BlElement new
					layout: BlFrameLayout new;
					clipChildren: false;
					constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical fitContent ];
					addChild: textElement.

			res := BlElement new
				clipChildren: false;
				"border: (BlBorder paint: Color red width: 1);"
				size: 10 @ 10;
				addChildren: {textAligned relocate: 0 @ -5.
						circle}.
			res userData at: #item put: x.
			res
						
 ];
		with: allRules flatten asSet.
	view layout custom: (MoodleQueryHorizontalTree new scaleBreadth: 1.6; scaleBreadthOffset: 1.3).
	view edges
		stencil: [:item :from :to | 
				| origin target color |
				origin := from userData at: #item.
				target := to userData at: #item.
				color := (selfRules includes: {origin. target})
					ifTrue: [Color blue] ifFalse: [Color red].
				(extraRules includes: {origin. target}) ifTrue: [color := Color green].
				BlLineElement new
				zIndex: -1;
				border: (BlBorder paint: (color alpha: 0.5))
			];
		connect: allRules
		from: #first
		to: #second.
	^ view
]

{ #category : #'as yet unclassified' }
TMQueryBuilder classSide >> gtQueryGraphFor: aView [
<gtClassView>
^aView forward 
		title: 'Иерархия запросов';
		priority: 15;
		object: [ self createGraph];
		view: #gtLiveFor:
]

{ #category : #rules }
TMQueryBuilder classSide >> rules [
<return: #aDictionary of: #Collection to: #CompiledMethod>
	^(self pragmas select: [:aPragma | aPragma selector = #rule:] thenCollect: 
		[ :aPragma | 
			| anArgument |
			anArgument := MoodleEventQuery parseRule: aPragma arguments first. 
			anArgument -> aPragma method.
			 ]) asDictionary
]

{ #category : #rules }
TMQueryBuilder >> argument: anObject for: aCollection [
self currentQueryArguments at: aCollection put: anObject.
]

{ #category : #rules }
TMQueryBuilder >> currentQueryArguments [
<return: #aDictionary of: #Collection to: #anObject>
	^self explicitRequirement
]
