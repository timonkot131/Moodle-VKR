Class {
	#name : #MLogDate,
	#superclass : #Object,
	#category : #'MoodleVKR-Utility'
}

{ #category : #accessing }
MLogDate class >> fromStringtoInt: aString [
| arr day month year |
	arr := '.' split: aString.
	day := arr first asInteger.
	month := arr second asInteger.
	year := arr at: 3 ifAbsent: [ DateAndTime now year asString ].
	year size = 2 ifTrue: [
		year := ('20', year).
	].
	^(DateAndTime year: year asInteger month: month  day: day) asUnixTime
	
]

{ #category : #accessing }
MLogDate class >> ofUnixToString: aNumber [
| date |
	date := DateAndTime fromUnixTime: aNumber.
	^'{1}-{2}-{3}' format: {date dayOfMonth asTwoCharacterString. date month asTwoCharacterString. date year}
]
