Class {
	#name : #ApiUser,
	#superclass : #Object,
	#category : #'MoodleVKR-API'
}

{ #category : #creation }
ApiUser class >> userStream: aString [
	| ids response |
	ids := ZnClient new
			url: 'http://localhost/webservice/rest/server.php';
			queryAt: 'wsfunction' put: 'core_search_get_relevant_users ';
			queryAt: 'wstoken' put: aString;
			queryAt: 'moodlewsrestformat' add: 'json';
			queryAt: 'query' add: '';
			formAt: 'courseid' put: '0';
			post.

	response := ZnClient new
			url: 'http://localhost/webservice/rest/server.php';
			queryAt: 'wsfunction' put: 'core_user_get_users_by_field';
			queryAt: 'wstoken' put: aString;
			queryAt: 'moodlewsrestformat' add: 'json';
			queryAt: 'field' put: 'id'.

	(STON fromString: ids)
		withIndexDo: [ :x :i | response formAt: 'values[' , (i - 1) asString , ']' put: (x at: 'id') asString ]
]
