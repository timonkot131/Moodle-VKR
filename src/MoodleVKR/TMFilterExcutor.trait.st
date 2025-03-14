Trait {
	#name : #TMFilterExcutor,
	#category : #'MoodleVKR-Database'
}

{ #category : #'as yet unclassified' }
TMFilterExcutor >> execute [
| res stream chunks   | 
			res := MoodleDBEventLog storedInstances select: self.
			stream := IteratorStream forPosStream: res readStream.
			chunks := (stream asAsyncStream chunks: 50) cached  collect: [:logs | 
				|userids courseids courseJob userJob users courses apiUser apiCourse|
				apiUser := ApiUser forToken: MConfig token.
				apiCourse := ApiCourse forToken:  MConfig token.
				userids := (logs collect: #userid) asSet. 
				courseids := (logs collect: #courseid) asSet reject: #isZero.
				userJob := (apiUser completeUsersChunk: userids) 
					inject: Dictionary new into: [:dic :user | dic at: user id put: user; yourself].
				courseJob := (apiCourse completeCoursesChunk: courseids) 
					inject: Dictionary new into: [:dic :course | dic at: course id put: course; yourself]. .
				courses := courseJob wait.
				courses ifNil: [courses := Dictionary new].
				users := userJob wait.
				logs asAsyncStream collect: [:log  |
					MoodleEventLog new
						ip: log ip;
						user: (users at: log userid );
						course: (courses at: log courseid ifAbsent: [nil]);
						eventName: log eventname;
						id: log id
				] 
			].
			^chunks flatten
]

{ #category : #'as yet unclassified' }
TMFilterExcutor >> gtFilterQueryFor: aView [
<gtToolView>
<gtView>
^ aView columnedList
		title: 'Items';
		priority: 5;
		items: [ (ApiQueryBuilder query: self    token: MConfig token) execute asyncSimilarCopy.];
		column: 'Number' text: [ :_ :anIndex | anIndex ] width: 50;
		column: 'Name' text: [ :each | each ];
		actionUpdateButton
]

{ #category : #'as yet unclassified' }
TMFilterExcutor >> gtPreloaded: aView [
<gtToolView>
<gtView>
^ aView columnedList
		title: 'Preloaded';
		priority: 5;
		items: [ (ApiQueryBuilder query: self    token: MConfig token) preloaded asyncSimilarCopy.];
		column: 'Number' text: [ :_ :anIndex | anIndex ] width: 50;
		column: 'Name' text: [ :each | each ];
		actionUpdateButton

]
