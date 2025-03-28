Class {
	#name : #MLogTime,
	#superclass : #Object,
	#category : #'MoodleVKR-Utility'
}

{ #category : #accessing }
MLogTime class >> dayInSeconds [
^ (60 * 60 * 24)
]

{ #category : #accessing }
MLogTime class >> fromStringtoInt: aString [
	| arr hours minutes |
	arr := ':' split: aString.
	hours := arr first asInteger.
	minutes := arr second asInteger.
	^(Time hour: hours minute: minutes second: 0) asSeconds
]

{ #category : #'as yet unclassified' }
MLogTime class >> ofUnixToString: aNumber [
	| date |
	date := DateAndTime fromUnixTime: aNumber.
	^ '{1}:{2}'
		format: {date hours asTwoCharacterString.
				date minutes asTwoCharacterString}
]
