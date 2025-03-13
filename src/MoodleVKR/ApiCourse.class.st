Class {
	#name : #ApiCourse,
	#superclass : #Object,
	#instVars : [
		'token'
	],
	#category : #'MoodleVKR-API'
}

{ #category : #'as yet unclassified' }
ApiCourse class >> forToken: token [ 
	^self new token: token.
]

{ #category : #'as yet unclassified' }
ApiCourse >> completeCourses [
	| response |
	response := ZnClient new
			url: 'http://localhost/webservice/rest/server.php';
			streaming: true;
			queryAt: 'wsfunction' put: 'core_course_get_courses_by_field';
			queryAt: 'wstoken' put: token;
			queryAt: 'moodlewsrestformat' add: 'json'.

	^ AsyncIteratorStream
		forIterator: (JSONIterator forStream: response post of: MoodleCourse)
]

{ #category : #'as yet unclassified' }
ApiCourse >> token: aString [
	token := aString. 
]
