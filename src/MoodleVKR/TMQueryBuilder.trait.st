Trait {
	#name : #TMQueryBuilder,
	#category : #'MoodleVKR-Model'
}

{ #category : #creation }
TMQueryBuilder classSide >> createGraph [
	self createGraph: GtMondrian new.
]

{ #category : #accessing }
TMQueryBuilder classSide >> createGraph: aGtMondrian [
	| mainRules view selfRules extraRules allRules |
	mainRules := MoodleEventQuery
			computeAssociations: MoodleEventQuery ruleHierarchy
			forClass: self.
	selfRules := MoodleEventQuery
			computeAssociations: self rules keys
			forClass: self.
	extraRules := selfRules difference: mainRules.
	allRules := mainRules , extraRules.
	view := aGtMondrian.
	view nodes
		stencil: [ :x | self drawNode: x ];
		with: allRules flatten asSet.
	view layout
		custom: (MoodleQueryHorizontalTree new
				scaleBreadth: 1.6;
				scaleBreadthOffset: 1.3).
	view edges
		stencil: (self edgeStencil: selfRules extra: extraRules);
		connect: allRules
			from: #first
			to: #second.
	^ view
]

{ #category : #accessing }
TMQueryBuilder classSide >> drawNode: x [
	| textElement textAligned res circle text |
	circle := BlElement new
			border: (BlBorder paint: Color black width: 1);
			geometry: BlEllipseGeometry new;
			padding: (BlInsets all: 5);
			size: 10 @ 10.

	text := x class = QuerySelector ifTrue: [ x second ] ifFalse: x.

	textElement := (BlTextElement
			text: (text asRopedText
					foreground: Color black;
					fontSize: 3)) constraintsDo: [ :c | c frame horizontal alignCenter ].

	textAligned := BlElement new
			layout: BlFrameLayout new;
			clipChildren: false;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical fitContent ];
			addChild: textElement.

	res := BlElement new
			clipChildren: false;
			size: 10 @ 10;
			addChildren: {textAligned relocate: 0 @ -5.
					circle}.	"border: (BlBorder paint: Color red width: 1);"

	x class = QuerySelector
		ifTrue: [ | aptitude |
			aptitude := BrGlamorousWithContextMenuAptitude content: [ x asElement ].
			res aptitude: aptitude ].
	res userData at: #item put: x.

	^ res
]

{ #category : #accessing }
TMQueryBuilder classSide >> edgeStencil: selfRules extra: extraRules [
	^ [ :item :from :to | 
	| origin target color |
	origin := from userData at: #item.
	target := to userData at: #item.
	color := (selfRules
			includes: {origin.
					target}) ifTrue: [ Color blue ] ifFalse: [ Color red ].
	(extraRules
		includes: {origin.
				target}) ifTrue: [ color := Color green ].
	BlLineElement new
		zIndex: -1;
		border: (BlBorder paint: (color alpha: 0.5)) ]
]

{ #category : #view }
TMQueryBuilder classSide >> gtQueryGraphFor: aView [
<gtClassView>
^aView mondrian 
		title: 'Иерархия запросов';
		priority: 15;
		painting: [ :aMondrian | self createGraph: aMondrian];
		actionButtonIcon: BrGlamorousVectorIcons refresh 
		action: [ :aButton :aTab | aTab viewContentElement phlow syncUpdate ] 
]

{ #category : #rules }
TMQueryBuilder classSide >> rules [
<return: #aDictionary of: #Collection to: #CompiledMethod>
	^(self class pragmas select: [:aPragma | aPragma selector = #rule:] thenCollect: 
		[ :aPragma | 
			| anArgument |
			anArgument := MoodleEventQuery parseRule: aPragma arguments first. 
			anArgument -> aPragma method.
			 ]) asDictionary
]

{ #category : #rules }
TMQueryBuilder >> argument: anObject for: aCollection [
self currentQueryFilters at: aCollection put: anObject.
]

{ #category : #rules }
TMQueryBuilder >> currentQueryFilters [
<return: #aDictionary of: #Collection to: #anObject>
	^self explicitRequirement
]
