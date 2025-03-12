Trait {
	#name : #TMFilterExcutor,
	#category : #'MoodleVKR-Database'
}

{ #category : #'as yet unclassified' }
TMFilterExcutor >> execute [
| res stream users job chunks|
			res := MoodleDBEventLog storedInstances select: self.
			stream := IteratorStream forPosStream: res readStream.
			chunks := (stream asAsyncStream chunks: 50) cached collect: [:logs | 
				|userids apiUser|
				apiUser := ApiUser forToken: MConfig token.
				userids := (logs collect: #userid) asSet. 
				job := (apiUser completeUsersChunk: userids) 
					inject: Dictionary new into: [:dic :user | dic at: user id put: user; yourself].
				users := job wait.
				(logs collect: [:log  |
					MoodleEventLog new
						user: (users at: log userid);
						eventName: log eventname;
						id: log id
				]) asAsyncStream
			].
			^chunks flatten
]
