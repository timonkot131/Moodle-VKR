Class {
	#name : #ApiCourse,
	#superclass : #Object,
	#instVars : [
		'token',
		'iterator'
	],
	#category : #'MoodleVKR-API'
}

{ #category : #'as yet unclassified' }
ApiCourse class >> forToken: token [ 
	^self new token: token.
]

{ #category : #utilities }
ApiCourse >> adjust: iterator [
	[ iterator charReader peek = $[ ]
		whileFalse: [ iterator charReader atEnd
				ifFalse: [ iterator charReader next ]
				ifTrue: [ 
					|err|
				iterator jsonReader close.
					err := Error new
						messageText: 'Error accured'.
					err signal.
						]
					 ]
]

{ #category : #'as yet unclassified' }
ApiCourse >> close [ 
iterator ifNotNil: [
	iterator close.
]
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
	iterator := JSONIterator forStream: response post of: MoodleCourse.
	self adjust: iterator.
	^ AsyncIteratorStream forIterator: iterator
]

{ #category : #'as yet unclassified' }
ApiCourse >> completeCoursesChunk: ids [ 
	| response |
	ids isEmpty ifTrue: [^{} asAsyncStream].
		response := ZnClient new 
		url: 'http://localhost/webservice/rest/server.php';
		streaming: true;
		queryAt: 'wsfunction' put: 'core_course_get_courses_by_field';
		queryAt: 'wstoken' put: token;
		queryAt: 'moodlewsrestformat' add: 'json'; 
		queryAt: 'field' add: 'ids';
		formAt: 'value' put: (', ' join: ids).
	iterator :=  JSONIterator forStream: response post of: MoodleCourse.
	self adjust: iterator.
	^ AsyncIteratorStream forIterator: iterator
]

{ #category : #'as yet unclassified' }
ApiCourse >> completeCoursesChunk: anArray field: aString [
	| response |
	response := anArray collect: [:x | self course: x by: aString].

	^ response asAsyncStream flatten.
]

{ #category : #'as yet unclassified' }
ApiCourse >> course: anObject by: aString [
| response |
	response := ZnClient new 
		url: 'http://localhost/webservice/rest/server.php';
		streaming: true;
		queryAt: 'wsfunction' put: 'core_course_get_courses_by_field';
		queryAt: 'wstoken' put: token;
		queryAt: 'moodlewsrestformat' add: 'json'; 
		queryAt: 'field' add: aString;
		formAt: 'value' put: anObject.
	iterator :=  JSONIterator forStream: response post of: MoodleCourse.
	self adjust: iterator.
	
	^ AsyncIteratorStream forIterator: iterator
]

{ #category : #acccessing }
ApiCourse >> iterator [
^ iterator
]

{ #category : #'as yet unclassified' }
ApiCourse >> subscribeToCancel: aQueryCancellation [
	aQueryCancellation weak 
		when: MoodleCancelEvent
		send: #close
		to: self.
]

{ #category : #'as yet unclassified' }
ApiCourse >> token: aString [
	token := aString. 
]
