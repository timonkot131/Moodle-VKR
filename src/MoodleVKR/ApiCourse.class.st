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
ApiCourse >> adjust: anIterator [
	| buffer |
	buffer := String
			streamContents: [ :out | 
				[ anIterator charReader peek = $[ ]
					whileFalse: [ anIterator charReader atEnd ifFalse: [ anIterator charReader next ] ] ].
	anIterator charReader atEnd
		ifTrue: [ ((NeoJSONReader on: buffer readStream)
				mapInstVarsFor: MoodleExecutionError;
				nextAs: MoodleExecutionError) signal ]
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
	response := (MConfig clientFor: 'core_course_get_courses_by_field')
			streaming: true.
	iterator := JSONIterator forStream: response post of: MoodleCourse.
	iterator adjust.
	^ AsyncIteratorStream forIterator: iterator
]

{ #category : #'as yet unclassified' }
ApiCourse >> completeCoursesChunk: ids [ 
	| response |
	ids isEmpty ifTrue: [^{} asAsyncStream].
		response := (MConfig clientFor: 'core_course_get_courses_by_field')
		streaming: true; 
		queryAt: 'field' add: 'ids';
		formAt: 'value' put: (', ' join: ids).
	iterator :=  JSONIterator forStream: response post of: MoodleCourse.
	iterator adjust.
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
	response := 
		(MConfig clientFor: 'core_course_get_courses_by_field')
		streaming: true;
		queryAt: 'field' add: aString;
		formAt: 'value' put: anObject.
	iterator :=  JSONIterator forStream: response post of: MoodleCourse.
	iterator adjust.
	
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
