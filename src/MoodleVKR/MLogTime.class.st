Class {
	#name : #MLogTime,
	#superclass : #Object,
	#category : #'MoodleVKR-Utility'
}

{ #category : #'as yet unclassified' }
MLogTime class >> ofUnix: aNumber [
	| date |
	date := DateAndTime fromUnixTime: aNumber.
	^ '{1}:{2}'
		format: {date hours asTwoCharacterString.
				date minutes asTwoCharacterString}
]
