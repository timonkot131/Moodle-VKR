Extension { #name : #GtMagritteViewModel }

{ #category : #'*MoodleVKR' }
GtMagritteViewModel class >> forMyObject: anObject [ 
^ self new
		  mementoBlock: [ FixedMemento model: anObject ]
		  object: anObject
]
