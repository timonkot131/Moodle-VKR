Class {
	#name : #ApiUser,
	#superclass : #Object,
	#instVars : [
		'token'
	],
	#category : #'MoodleVKR-API'
}

{ #category : #initialization }
ApiUser class >> forToken: aString [ 
	^self new token: aString.
]

{ #category : #'stream creation' }
ApiUser >> completeUsers [
	| chunked fullUsers mapped |
	mapped := self relatedUsers asAsyncStream map: [ :x | x at: 'id' ].
	chunked := mapped chunks: 50.
	fullUsers := chunked collect: [ :ids | self completeUsersChunk: ids ].
	^ fullUsers flatten
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
	^ AsyncIteratorStream forIterator: (JSONIterator forStream: (response post) of: MoodleUser) 
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
	^ AsyncIteratorStream forIterator: (JSONIterator forStream: (response post) of: MoodleUser) 
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

{ #category : #accessing }
ApiUser >> token [
^ token
]

{ #category : #acccessing }
ApiUser >> token: aString [ 
	token := aString
]
