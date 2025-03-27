Class {
	#name : #MLogDate,
	#superclass : #Object,
	#category : #'MoodleVKR-Utility'
}

{ #category : #accessing }
MLogDate class >> ofUnix: aNumber [
| date |
	date := DateAndTime fromUnixTime: aNumber.
	^'{1}-{2}-{3}' format: {date dayOfMonth asTwoCharacterString. date month asTwoCharacterString. date year}
]
