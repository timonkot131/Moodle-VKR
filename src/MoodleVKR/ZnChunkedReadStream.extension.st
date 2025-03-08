Extension { #name : #ZnChunkedReadStream }

{ #category : #'*MoodleVKR' }
ZnChunkedReadStream >> asAsyncStream [
	^AsyncIteratorStream forIterator: (JSONIterator forStream: self).
]
