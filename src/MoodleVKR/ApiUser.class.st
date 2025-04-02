Class {
	#name : #ApiUser,
	#superclass : #Object,
	#instVars : [
		'token',
		'iterator'
	],
	#category : #'MoodleVKR-API'
}

{ #category : #initialization }
ApiUser class >> forToken: aString [ 
	^self new token: aString.
]

{ #category : #'as yet unclassified' }
ApiUser >> adjust: anIterator [
	| buffer |
	buffer := String
			streamContents: [ :out | 
				[ anIterator charReader peek = $[ |
				  anIterator charReader atEnd ]
					whileFalse: [ out nextPut: anIterator charReader next  ] ].
	anIterator charReader atEnd
		ifTrue: [ ((NeoJSONReader on: buffer readStream)
				mapInstVarsFor: MoodleExecutionError;
				nextAs: MoodleExecutionError) signal ]
]

{ #category : #'as yet unclassified' }
ApiUser >> close [ 
iterator ifNotNil: [
	iterator close.
]
]

{ #category : #'stream creation' }
ApiUser >> completeUsers [
	| chunked fullUsers mapped | 
	mapped := self relatedUsers asAsyncStream map: [ :x | x at: 'id' ].
	chunked := mapped chunks: 50.
	fullUsers := chunked collect: [ :ids | self completeUsersChunk: ids ].
	^ fullUsers flatten
]

{ #category : #'as yet unclassified' }
ApiUser >> completeUsers: aDictionary [
	| response |
	response := ZnClient new
			url: 'http://localhost/webservice/rest/server.php';
			queryAt: 'wsfunction' put: 'core_user_get_users';
			streaming: true;
			queryAt: 'wstoken' put: token;
			queryAt: 'moodlewsrestformat' add: 'json'.
	aDictionary associations
		withIndexDo: [ :x :i | 
			response 
				formAt: 'criteria[' , (i - 1) asString , '][key]'
				put: x key asString.
			response
				formAt: 'criteria[' , (i - 1) asString , '][value]'
				put: x value asString ].
	iterator := JSONIterator forStream: response post of: MoodleUser.
	self adjust: iterator.
	^ AsyncIteratorStream forIterator: iterator
]

{ #category : #'stream creation' }
ApiUser >> completeUsersChunk: ids [
	| response |
	response := ZnClient new
			url: 'http://localhost/webservice/rest/server.php';
			queryAt: 'wsfunction' put: 'core_user_get_users_by_field';
			streaming: true;
			queryAt: 'wstoken' put: token;
			queryAt: 'moodlewsrestformat' add: 'json';
			queryAt: 'field' put: 'id'.
	ids
		withIndexDo: [ :x :i | response formAt: 'values[' , (i - 1) asString , ']' put: x asString ].
	iterator := JSONIterator forStream: response post of: MoodleUser.
	^ AsyncIteratorStream forIterator: iterator
]

{ #category : #'stream creation' }
ApiUser >> completeUsersChunk: aCollection field: aString [
	| response |
	response := ZnClient new
			url: 'http://localhost/webservice/rest/server.php';
			queryAt: 'wsfunction' put: 'core_user_get_users_by_field';
			streaming: true;
			queryAt: 'wstoken' put: token;
			queryAt: 'moodlewsrestformat' add: 'json';
			queryAt: 'field' put: aString.
	aCollection
		withIndexDo: [ :x :i | response formAt: 'values[' , (i - 1) asString , ']' put: x asString ].
	iterator := JSONIterator forStream: response post of: MoodleUser.
	^ AsyncIteratorStream forIterator: iterator
]

{ #category : #'as yet unclassified' }
ApiUser >> iterator [
^ iterator
]

{ #category : #'stream creation' }
ApiUser >> relatedUsers [
	| response |
	response :=  ZnClient new
		url: 'http://localhost/webservice/rest/server.php';
		queryAt: 'wsfunction' put: 'core_search_get_relevant_users ';
		queryAt: 'wstoken' put: token;
		queryAt: 'moodlewsrestformat' add: 'json';
		queryAt: 'query' add: '';
		formAt: 'courseid' put: '0';
		streaming: true.
	^response post
]

{ #category : #'as yet unclassified' }
ApiUser >> subscribeToCancel: aQueryCancellation [
	aQueryCancellation weak 
		when: MoodleCancelEvent
		send: #close
		to: self.
]

{ #category : #accessing }
ApiUser >> token [
^ token
]

{ #category : #acccessing }
ApiUser >> token: aString [ 
	token := aString
]
