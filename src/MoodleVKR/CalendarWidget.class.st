Class {
	#name : #CalendarWidget,
	#superclass : #Object,
	#instVars : [
		'monthNum',
		'year',
		'itemStream'
	],
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #accessing }
CalendarWidget class >> daysOfWeek [
^#(Понедельник Вторник Среда Четверг Пятница Суббота Воскресенье)
]

{ #category : #accessing }
CalendarWidget class >> toRusDayOfWeek: anInteger [
anInteger = 1 ifTrue: [^7].
^anInteger - 1
]

{ #category : #'as yet unclassified' }
CalendarWidget class >> year: anInteger month: aMonthInteger [
^self new year: anInteger; monthNum: aMonthInteger; itemStream: ({} asAsyncStream).
]

{ #category : #'as yet unclassified' }
CalendarWidget class >> year: anInteger month: aMonthInteger stream: anAsyncStream [
^self new year: anInteger; monthNum: aMonthInteger; itemStream: anAsyncStream.
]

{ #category : #'as yet unclassified' }
CalendarWidget >> animTime [
	^ 200 milliSeconds
]

{ #category : #'as yet unclassified' }
CalendarWidget >> asElement [
	^ BlElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		addChildren: {BlElement new
					layout: BlLinearLayout horizontal;
					constraintsDo: [ :c | c horizontal matchParent ];
					addChildren: (CalendarWidget daysOfWeek
							collect: [ :anItem | 
								BlElement new
									layout: BlFrameLayout new;
									constraintsDo: [ :c | c horizontal matchParent ];
									addChild: (BlTextElement new
											text: anItem asRopedText;
											constraintsDo: [ :c | 
												c frame horizontal alignCenter.
												c frame vertical alignCenter ]) ]).
				BlElement new 
					layout: (BlGridLayout new columnCount: 7);
					border: (BlBorder paint: Color gray width: 2);
					constraintsDo: [ :c | 
						c vertical fitContent.
						c horizontal matchParent ];
					addChildren: (self daysOfMonth collect: [ :anItem | self dayElement: anItem ])}.
]

{ #category : #'as yet unclassified' }
CalendarWidget >> dayElement: anItem [
	^ BlElement new
		id: #day;
		layout: BlFrameLayout new;
		background: (anItem month = self monthNum
			ifTrue: [ Color white ]
			ifFalse: [ Color veryVeryLightGray ]);
		border: (BlBorder paint: Color gray width: 1);
		constraintsDo: [ :c | c horizontal matchParent ];
		background: (anItem month = self monthNum
			ifTrue: [ Color white ]
			ifFalse: [ Color veryVeryLightGray ]);
		height: 60;
		padding: (BlInsets all: 10);
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncCounterSink new;
				whenUpdate: [ :anElement :aCounterSink | 
					| count |
					count := aCounterSink count.
					(count = 0 & anElement background paint color) = Color veryVeryLightGray
						ifFalse: [ anElement parent
							addAnimation: (BlParallelAnimation new
								add: (BlColorTransition new
									from: anElement background paint color;
									to: (self thresholdColor: count);
									duration: self animTime;
									onStepDo: [ :c | anElement background: c ])) ] ];
				forwardStream: (self itemStream asyncSimilarCopy
					filter: [  "GtJustContextStackSignal emit.":each | self isLog: each in: anItem ]) ];
		addChild: (BlTextElement new
				text: (anItem ifNil: [ '' asRopedText ] ifNotNil: [ :x | x dayOfMonth asRopedText ]))
]

{ #category : #accessing }
CalendarWidget >> daysOfMonth [
| firstDay prevMonthDays firstDayOfWeek prefix monthItems postfix |
	firstDay := (DateAndTime year: year month: monthNum day: 1).
prevMonthDays := (Month month: (monthNum - 1 = 0 ifTrue: [12] ifFalse: [monthNum - 1] )) daysInMonth.
firstDayOfWeek := 
	CalendarWidget toRusDayOfWeek: firstDay dayOfWeek .
prefix := (prevMonthDays - (firstDayOfWeek - 2) to: prevMonthDays) collect: 
	[:each |	
		(monthNum - 1 = 0 "Декабрь") 
			ifTrue: [DateAndTime year: year - 1 month: 12 day: each]
			ifFalse: [DateAndTime year: year month: monthNum - 1 day: each]]. 
monthItems := ( 1 to: (Month month: monthNum) daysInMonth) collect: 
	[:each | DateAndTime year: year month: monthNum day: each].
postfix := (1 to: 7 - (prefix, monthItems) size % 7) collect: 
	[:each |	
		(monthNum + 1 = 13 "Январь") 
			ifTrue: [DateAndTime year: year + 1 month: 1 day: each]
			ifFalse: [DateAndTime year: year month: monthNum + 1 day: each]]. 
^(prefix, monthItems, postfix)
]

{ #category : #'as yet unclassified' }
CalendarWidget >> initialize [ 
super initialize.
]

{ #category : #'as yet unclassified' }
CalendarWidget >> isLog: aMoodleEventLog in: aDateAndTime [
	| valueInt |
	valueInt := aDateAndTime asUnixTime.
	^ aMoodleEventLog timeCreated < (valueInt + MLogTime dayInSeconds)
	 & (aMoodleEventLog timeCreated > valueInt)
]

{ #category : #accessing }
CalendarWidget >> itemStream [
	^ itemStream
]

{ #category : #accessing }
CalendarWidget >> itemStream: anObject [
	itemStream := anObject
]

{ #category : #accessing }
CalendarWidget >> monthNum [
	^ monthNum
]

{ #category : #accessing }
CalendarWidget >> monthNum: anObject [
	monthNum := anObject
]

{ #category : #'as yet unclassified' }
CalendarWidget >> offset [ 
^DateAndTime now offset asSeconds.
]

{ #category : #'as yet unclassified' }
CalendarWidget >> thresholdColor: anInteger [
anInteger <= 0 ifTrue: [^Color white].
anInteger <= 5 ifTrue: [^Color lightYellow].
anInteger <= 10 ifTrue: [^Color yellow].
anInteger <= 20 ifTrue: [^Color lightOrange].
anInteger > 20 ifTrue: [^Color orange].

]

{ #category : #accessing }
CalendarWidget >> year [
^year
]

{ #category : #accessing }
CalendarWidget >> year: anInteger [ 
year := anInteger
]
