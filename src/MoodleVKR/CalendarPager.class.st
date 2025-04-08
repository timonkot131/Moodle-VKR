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
^self new targetYear: anInteger; targetMonth: anInteger; user: aMoodleUser; updateItems.
]

{ #category : #'as yet unclassified' }
CalendarPager >> editorYear: anInteger [
	titleEditor text: anInteger asString asRopedText.
]

{ #category : #'as yet unclassified' }
CalendarPager >> forEventLog: aMoodleEventLog [ 
| dateTime | 
dateTime := DateAndTime fromUnixTime: aMoodleEventLog timeCreated.

]

{ #category : #'as yet unclassified' }
CalendarPager >> initialize [
titleEditor := BrEditor new
			aptitude: BrGlamorousRegularEditorAptitude new;
			beEditable;
			width: 100;
			vFitContent;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
			border: (BlBorder paint: Color veryLightGray width: 1).

pager := 
	BrPager new hMatchParent.
			
applyButton := 
	BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		action: [ 
			self targetYear: titleEditor text asInteger.
			self updateItems.
		 ];
		margin: (BlInsets top: 10);
		label: 'Ok';
		beLargeSize.

self 
	layout: BlLinearLayout vertical;
	constraintsDo: [:c | 
		c horizontal matchParent.
		c vertical fitContent.];
	addChild: 
		(BlElement new 
			layout: BlLinearLayout horizontal;
			addChildren: {titleEditor. applyButton}
			)
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
	streamItems := anObject
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
			u1 := (DateAndTime year: self targetYear month: self targetMonth) asUnixTime.
			u2 := (DateAndTime year: self targetYear + 1 month: self targetMonth) asUnixTime.
			(x timecreated > u1) & (x timecreated < u2) & (x userid = 4) ]) 
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
