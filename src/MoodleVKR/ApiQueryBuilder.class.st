Class {
	#name : #ApiQueryBuilder,
	#superclass : #Object,
	#traits : 'TMQueryBuilder',
	#classTraits : 'TMQueryBuilder classTrait',
	#instVars : [
		'currentQueryArguments',
		'query',
		'token'
	],
	#category : #'MoodleVKR-API'
}

{ #category : #converting }
ApiQueryBuilder class >> asElement [ 
	^self createGraph root. 
]

{ #category : #query }
ApiQueryBuilder class >> courseFullName: aSelected applyTo: anObject [
<rule: #(MoodleCourse fullname)>
^anObject fullName = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> courseId: aSelected applyTo: anObject [
<rule: #(courseid)>
anObject class ~= SSWDBBlockArgument ifTrue: [^#pass].
^anObject courseid = aSelected
]

{ #category : #execution }
ApiQueryBuilder class >> execute: aGtSearchQuery token: aString [
	| preloaded |
	preloaded := self preloaded: aGtSearchQuery token: aString.
	^ preloaded flatCollect: #execute
]

{ #category : #utilities }
ApiQueryBuilder class >> fetchCourses: aGtSearchFilter token: aToken [
| apiCourse byIdQuery |
apiCourse := ApiCourse forToken: aToken.
byIdQuery := aGtSearchFilter value: 'moodlecourse_id' asSymbol.
byIdQuery isArray 
		ifTrue: [
			byIdQuery ifEmpty: [^ {} asAsyncStream].
			^ apiCourse completeCoursesChunk: byIdQuery
		].
{'shortname'. 'category'} 
	do: [ :item | 
			| byQuery |
			byQuery := aGtSearchFilter value: ('moodlecourse_' , item) asSymbol.
			byQuery isArray
				ifTrue: [ byQuery ifEmpty: [ ^ {} asAsyncStream ].
				^ apiCourse completeCoursesChunk: byQuery field: item ]].
	^apiCourse completeCourses. 
]

{ #category : #utilities }
ApiQueryBuilder class >> fetchUsers: aGtSearchFilter token: aString [
	| apiUser |
	apiUser := ApiUser forToken: aString.
	{'email'. 'id'. 'username'}
		do: [ :item | 
			| byQuery |
			byQuery := aGtSearchFilter value: ('moodleuser_' , item) asSymbol.
			byQuery isArray
				ifTrue: [ byQuery ifEmpty: [ ^ {} asAsyncStream ].
				^ apiUser completeUsersChunk: byQuery field: item ]].
	^apiUser completeUsers.
]

{ #category : #query }
ApiQueryBuilder class >> moodleCourseCategory: aSelected applyTo: aMoodleCourse [
<rule: #(MoodleCourse category)>
^aMoodleCourse category = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleCourseId: aSelected applyTo: aMoodleCourse [
<rule: #(MoodleCourse id)>
^aMoodleCourse id = aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleCourseShortname: aSelected applyTo: aMoodleCourse [
<rule: #(MoodleCourse shortname)>
^aMoodleCourse shortname = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleQueryEventname: aSelected applyTo: anObject [
<rule: #(eventname)>
anObject class ~= SSWDBBlockArgument ifTrue: [^#pass].
^anObject eventname = aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleQueryIp: aSelected applyTo: aMoodleQuery [
<rule: #(ip)>
aMoodleQuery class ~= SSWDBBlockArgument ifTrue: [^#pass].
^aMoodleQuery eventname = aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserEmail: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser email)>
^aMoodleUser email = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserFullname: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser fullname)>
^aMoodleUser fullName = aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserId: aSelected applyTo: aMoodleUserOrSymbol [
<rule: #(MoodleUser id)>
^aMoodleUserOrSymbol id = aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserUsername: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser username)>
^aMoodleUser username = aSelected.
]

{ #category : #execution }
ApiQueryBuilder class >> preload: aGtSearchFilter token: aString [
	| userQuery courseQuery courses users |
	courseQuery := aGtSearchFilter value: MoodleCourse new.
	userQuery := aGtSearchFilter value: MoodleUser new.

	courses := courseQuery ~= #pass
		ifTrue: [ (self fetchCourses: aGtSearchFilter token: aString) cached
					collect: [ :anItem | 
						self fetchRule: {#courseid} select: anItem id ] ].

	users := userQuery ~= #pass
		ifTrue: [  (self fetchUsers: aGtSearchFilter token: aString) cached
					collect: [ :anItem |
						self fetchRule: {#userid} select: anItem id ] ].

	(courseQuery ~= #pass and: [ userQuery ~= #pass ])
		ifTrue: [ ^ users
				flatCollect: [ :anUser |
					courses collect: [ :aCourse | aGtSearchFilter & (anUser & aCourse) ] ] ].

	courseQuery ~= #pass
		ifTrue: [ ^ courses collect: [ :x | aGtSearchFilter & x ] ].
	userQuery ~= #pass ifTrue: [ ^ users collect: [ :x | aGtSearchFilter & x ] ].
	^ {aGtSearchFilter} asAsyncStream
]

{ #category : #execution }
ApiQueryBuilder class >> preloaded: aGtSearchFilter token: aString [
	^ aGtSearchFilter distributeAsync flatCollect: [ :aQuery | self preload: aQuery  token: aString]
]

{ #category : #initialization }
ApiQueryBuilder class >> query: aGtSearchFilter token: aString [
^self new query: aGtSearchFilter; token: aString.
]

{ #category : #utilities }
ApiQueryBuilder class >> queryMethodSelector: selector class: class [
^(class first asLowercase asString, class copyWithoutFirst)
			, (selector first asUppercase asString, selector copyWithoutFirst)
			, ': aSelected applyTo: a', class .
]

{ #category : #query }
ApiQueryBuilder class >> userId: aSelected applyTo: anObject [
<rule: #(userid)>
anObject class ~= SSWDBBlockArgument ifTrue: [^#pass].
^anObject userid = aSelected
]

{ #category : #utilities }
ApiQueryBuilder >> check: anObject [
(query value: anObject) = #pass ifTrue: 
	[^ #pass.]
	ifFalse: [^ query]
]

{ #category : #accessing }
ApiQueryBuilder >> query [
	^ query
]

{ #category : #accessing }
ApiQueryBuilder >> query: aGtSearchFilter [
	query := aGtSearchFilter.
]

{ #category : #accessing }
ApiQueryBuilder >> token [
	^ token
]

{ #category : #accessing }
ApiQueryBuilder >> token: anObject [
	token := anObject
]
