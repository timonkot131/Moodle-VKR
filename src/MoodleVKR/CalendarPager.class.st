Class {
	#name : #CalendarPager,
	#superclass : #BlElement,
	#instVars : [
		'titleEditor',
		'applyButton',
		'pager',
		'targetMonth',
		'targetYear',
		'streamItems',
		'user'
	],
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #'as yet unclassified' }
CalendarPager class >> forEventLog: aMoodleEventLog [ 
| dateTime | 
dateTime := DateAndTime fromUnixTime: aMoodleEventLog timeCreated.
^self year: dateTime year month: dateTime month user: aMoodleEventLog user.
]

{ #category : #'as yet unclassified' }
CalendarPager class >> year: anInteger month: aMonthInteger user: aMoodleUser [
	^self new
		targetYear: anInteger;
		targetMonth: aMonthInteger;
		user: aMoodleUser;
		editorYear: anInteger;
		updateItems.
]

{ #category : #'as yet unclassified' }
CalendarPager >> editorYear: anInteger [
	titleEditor text: anInteger asString asRopedText.
]

{ #category : #'as yet unclassified' }
CalendarPager >> initialize [
	| leftMover rightMover |
	super initialize.
	
	leftMover := self pageMover: '<' action: [
		self previousMonth.
		pager smoothScrollTo: self targetMonth
	].
	rightMover := self pageMover: '>' action: [ 
		self nextMonth.
		pager smoothScrollTo: self targetMonth
	 ].

	titleEditor := BrEditor new
			aptitude: BrGlamorousRegularEditorAptitude new;
			beEditable;
			width: 100;
			vFitContent;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
			border: (BlBorder paint: Color veryLightGray width: 1).

	pager := BrPager new  matchParent.

	applyButton := BrButton new
			aptitude: BrGlamorousButtonWithLabelAptitude new;
			action: [ 
				self targetYear: titleEditor text asInteger.
				self updateItems ];
			margin: (BlInsets top: 10);
			label: 'Ok';
			beLargeSize.


	self
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		addChildren: {"BlElement new
					layout: BlLinearLayout horizontal;
					addChildren: {titleEditor.
							applyButton}."
				BlElement new
					layout: BlLinearLayout horizontal;
					constraintsDo: [:c | 
						c vertical matchParent.
						c horizontal matchParent.
					];
					addChildren: {leftMover.
							pager. rightMover}}
]

{ #category : #'as yet unclassified' }
CalendarPager >> nextMonth [
	self targetMonth = 12
		ifTrue: [
			^self targetMonth: 1
		].
	self targetMonth: self targetMonth + 1
]

{ #category : #'as yet unclassified' }
CalendarPager >> pageMover: aString action: aBlock [
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
		constraintsDo: [ :c | c vertical matchParent ];
		addChild: text;
		when: BlClickEvent do: aBlock
]

{ #category : #'as yet unclassified' }
CalendarPager >> previousMonth [
	self targetMonth = 1
		ifTrue: [
			^self targetMonth: 12
		].
	self targetMonth: self targetMonth - 1
]

{ #category : #accessing }
CalendarPager >> streamItems [
	^ streamItems
]

{ #category : #accessing }
CalendarPager >> streamItems: anObject [
	streamItems := anObject.
	pager removeAllPages.
	1 to: 12 do: [:item |
		pager addPage:
			(BrPagerPageElement new
				weight: 1.0;
				layout: BlFrameLayout new;
				addChild:  (CalendarWidget
						year: self targetYear
						month: item
						stream: self streamItems) asElement)
			].
	pager scrollTo: self targetMonth.
]

{ #category : #accessing }
CalendarPager >> targetMonth [
	^ targetMonth
]

{ #category : #accessing }
CalendarPager >> targetMonth: anObject [
	targetMonth := anObject
]

{ #category : #accessing }
CalendarPager >> targetYear [
	^ targetYear
]

{ #category : #accessing }
CalendarPager >> targetYear: anObject [
	targetYear := anObject
]

{ #category : #'as yet unclassified' }
CalendarPager >> updateItems [
| stream asyncStream |
	stream := (MoodleDBEventLog storedInstances
		satisfying: [ :x | 
			| u1 u2 |
			u1 := (DateAndTime year: self targetYear month: 1) asUnixTime.
			u2 := (DateAndTime year: self targetYear + 1 month:1) asUnixTime.
			(x timecreated > u1) & (x timecreated < u2) & (x userid = self user id) ]) 
		readStream.
asyncStream := (IteratorStream forPosStream: stream) asAsyncStream cached
		collect: [ :x | MoodleEventLog new timeCreated: x timecreated ].
self streamItems: asyncStream
]

{ #category : #accessing }
CalendarPager >> user [
	^ user
]

{ #category : #accessing }
CalendarPager >> user: anObject [
	user := anObject
]
