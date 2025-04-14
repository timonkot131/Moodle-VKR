Class {
	#name : #ApiGroup,
	#superclass : #Object,
	#instVars : [
		'token',
		'iterator'
	],
	#category : #'MoodleVKR-API'
}

{ #category : #'as yet unclassified' }
ApiGroup class >> forToken: aString [ 
	^self new token: aString.
]

{ #category : #'as yet unclassified' }
ApiGroup >> close [ 
iterator ifNotNil: [
	iterator close.
]
]

{ #category : #'as yet unclassified' }
ApiGroup >> completeGroups: ids [
| response |
	response := ZnClient new
			url: 'http://localhost/webservice/rest/server.php';
			streaming: true;
			queryAt: 'wsfunction' put: 'core_group_get_groups';
			queryAt: 'moodlewsrestformat' add: 'json';
			queryAt: 'wstoken' put: token;
			queryAt: 'moodlewsrestformat' add: 'json'.
			
	ids 
		withIndexDo: [:x :i | response formAt: 'groupids[', (i - 1) asString, ']' put: x asString].	
	
	iterator := JSONIterator forStream: response post of: MoodleGroup.
	iterator adjust.
	^ AsyncIteratorStream forIterator: iterator
]

{ #category : #'as yet unclassified' }
ApiGroup >> groupMembers: ids [
| response apiUser |
	apiUser := ApiUser forToken: token.
	response := ZnClient new
			url: 'http://localhost/webservice/rest/server.php';
			queryAt: 'wsfunction' put: 'core_group_get_group_members';
			queryAt: 'wstoken' put: token; 
			queryAt: 'moodlewsrestformat' add: 'json'.
	ids 
		withIndexDo: [:x :i | response formAt: 'groupids[', (i - 1) asString ,']' put: x asString].
	
	^apiUser completeUsersChunk: ((STON fromString: response post) flatCollect: [:x | x at: 'userids']) asSet
]

{ #category : #'as yet unclassified' }
ApiGroup >> groupOfCourse: aCourseId ofUser: aUserId [
| response |
	response := ZnClient new
			url: 'http://localhost/webservice/rest/server.php';
			queryAt: 'wsfunction' put: 'core_group_get_course_user_groups';
			streaming: true; 
			queryAt: 'wstoken' put: token;
			queryAt: 'moodlewsrestformat' add: 'json';
			queryAt: 'courseid' put: aCourseId;
			queryAt: 'userid' put: aUserId.
			
	iterator := JSONIterator forStream: response post of: MoodleGroup.
	iterator adjust.
	^ AsyncIteratorStream forIterator: iterator
]

{ #category : #'as yet unclassified' }
ApiGroup >> groupsOfCourse: anIntegerId [
| response |
	response := ZnClient new
			url: 'http://localhost/webservice/rest/server.php';
			queryAt: 'wsfunction' put: 'core_group_get_course_groups';
			streaming: true; 
			queryAt: 'wstoken' put: token;
			queryAt: 'moodlewsrestformat' add: 'json';
			queryAt: 'courseid' put: anIntegerId.
			
	iterator := JSONIterator forStream: response post of: MoodleGroup.
	iterator adjust.
	^ AsyncIteratorStream forIterator: iterator
]

{ #category : #'as yet unclassified' }
ApiGroup >> subscribeToCancel: aQueryCancellation [
	aQueryCancellation weak 
		when: MoodleCancelEvent
		send: #close
		to: self.
]

{ #category : #'as yet unclassified' }
ApiGroup >> token: aString [ 
token := aString
]
