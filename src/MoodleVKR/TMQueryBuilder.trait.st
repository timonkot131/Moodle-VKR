Trait {
	#name : #TMQueryBuilder,
	#category : #'MoodleVKR-Model'
}

{ #category : #accessing }
TMQueryBuilder classSide >> createGraph [
	| arr view  |
	arr := MoodleEventQuery computeAssociations: MoodleEventQuery ruleHierarchy.
	view := GtMondrian new.
	view nodes
		stencil: [ :x |  
			| textElement textAligned  circle text |
			circle := BlElement new
					border: (BlBorder paint: Color black width: 1);
					geometry: BlEllipseGeometry new;
					padding: (BlInsets all: 5);
					size: 10 @ 10.

			text := x isArray ifTrue: [ x second ] ifFalse: x.


			textElement := (BlTextElement
					text: (text asRopedText
							foreground: Color gray;
							fontSize: 3)) constraintsDo: [ :c | c frame horizontal alignCenter ].

			textAligned := BlElement new
					layout: BlFrameLayout new;
					clipChildren: false;
					constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical fitContent ];
					addChild: textElement.

			BlElement new
				clipChildren: false;
				size: 10 @ 10;
				addChildren: {textAligned relocate: 0 @ -5.
						circle}	"border: (BlBorder paint: Color red width: 1);" ];
		with: arr flatten asSet.
	view layout custom: (MoodleQueryHorizontalTree new scaleBreadth: 1.6; scaleBreadthOffset: 1.3).
	view edges
		connect: arr
		from: #first
		to: #second.
	^ view
]

{ #category : #rules }
TMQueryBuilder classSide >> rules [
<return: #aDictionary of: #Collection to: #CompiledMethod>
	(self class pragmas collect: 
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
