Class {
	#name : #ApiQueryBuilder,
	#superclass : #Object,
	#traits : 'TMQueryBuilder',
	#classTraits : 'TMQueryBuilder classTrait',
	#instVars : [
		'query',
		'token',
		'cancellation'
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
ApiQueryBuilder class >> moodleGroupName: aSelected applyTo: aMoodleGroup [
<rule: #(MoodleCourse MoodleGroup name)>
^aMoodleGroup name = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleQueryContextlevel: aSelected applyTo: aMoodleQuery [
<rule: #(contextlevel)>
aMoodleQuery class ~= SSWDBBlockArgument ifTrue: [^#pass].
^aMoodleQuery contextlevel = (MoodleEventQuery contextLevels at: aSelected)
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
^aMoodleQuery ip like: aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleQueryTimecreated: aSelected applyTo: aMoodleQuery [
	<rule: #(timecreated)>
	| strings op valueString isTime timeCreated offset valueInt intervalOffset |
	[ aMoodleQuery class ~= SSWDBBlockArgument ifTrue: [ ^ #pass ].
	offset := DateAndTime now offset asSeconds.
	aSelected isEmptyOrNil ifTrue: [ ^ false ].
	strings := ' ' split: aSelected.
	op := '='.

	strings size = 2
		ifTrue: [ op := strings first.
			valueString := strings second ]
		ifFalse: [ valueString := aSelected ].
	isTime := valueString includesSubstring: ':'.
	isTime
		ifTrue: [ intervalOffset := 60.	"seconds"
			timeCreated := (aMoodleQuery timecreated + offset) \\ MLogTime dayInSeconds.
			valueInt := MLogTime fromStringtoInt: valueString ]
		ifFalse: [ intervalOffset := MLogTime dayInSeconds.
			timeCreated := aMoodleQuery timecreated.
			valueInt := MLogDate fromStringtoInt: valueString ].
	op = '>' ifTrue: [ ^ timeCreated > valueInt ].
	op = '<' ifTrue: [ ^ timeCreated < valueInt ].
	^ isTime
		ifFalse: [ aMoodleQuery timecreated + offset < (valueInt + intervalOffset)
				& (aMoodleQuery timecreated + offset > valueInt) ]
		ifTrue: [ (aMoodleQuery timecreated + offset) \\ MLogTime dayInSeconds
				< (valueInt + intervalOffset)
				& ((aMoodleQuery timecreated + offset) \\ MLogTime dayInSeconds > valueInt) ] ]
		on: Error
		do: [ :anError | (MoodleFilterError new messageText: 'Неправильный формата даты/времени') signal ]
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserAuth: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser auth)>
^aMoodleUser auth = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserEmail: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser email)>
^aMoodleUser email = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserFirstname: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser firstname)>
^aMoodleUser firstName = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserId: aSelected applyTo: aMoodleUserOrSymbol [
<rule: #(MoodleUser id)>
^aMoodleUserOrSymbol id = aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserLastname: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser lastname)>
^aMoodleUser lastName = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserUsername: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser username)>
^aMoodleUser userName = aSelected.
]

{ #category : #utilities }
ApiQueryBuilder class >> queryMethodSelector: selector class: class [
^(class first asLowercase asString, class copyWithoutFirst)
			, (selector first asUppercase asString, selector copyWithoutFirst)
			, ': aSelected applyTo: a', class .
]

{ #category : #initialization }
ApiQueryBuilder class >> token: aString cancellation: aQueryCancellation [
^self new 
	token: aString;
	cancellation: aQueryCancellation
]

{ #category : #query }
ApiQueryBuilder class >> userId: aSelected applyTo: anObject [
<rule: #(userid)>
anObject class ~= SSWDBBlockArgument ifTrue: [^#pass].
^anObject userid = aSelected
]

{ #category : #accessing }
ApiQueryBuilder >> cancellation [
cancellation ifNil: [
	cancellation := QueryCancellation new.
].
^cancellation
]

{ #category : #accessing }
ApiQueryBuilder >> cancellation: aQueryCancellation [ 
cancellation := aQueryCancellation.
]

{ #category : #execution }
ApiQueryBuilder >> execute: aGtSearchQuery [
	| preloaded |
	preloaded := self preloaded: aGtSearchQuery.
	^ (preloaded flatCollect: [:item | item execute: self cancellation]) withoutDuplicates.
]

{ #category : #utilities }
ApiQueryBuilder >> fetchCourses: aGtSearchFilter [
	| apiCourse byIdQuery |
	apiCourse := ApiCourse forToken: self token.
	apiCourse subscribeToCancel: self cancellation.
	byIdQuery := aGtSearchFilter value: 'moodlecourse_id' asSymbol.
	byIdQuery isArray
		ifTrue: [ byIdQuery ifEmpty: [ ^ {} asAsyncStream ].
			^ apiCourse completeCoursesChunk: byIdQuery ].
	{'shortname'}
		do: [ :item | 
			| byQuery |
			byQuery := aGtSearchFilter
				value: ('moodlecourse_' , item) asSymbol.
			byQuery isArray
				ifTrue: [ byQuery ifEmpty: [ ^ {} asAsyncStream ].
					^ (apiCourse completeCoursesChunk: byQuery field: item) select: aGtSearchFilter ] ].
	^ apiCourse completeCourses select: aGtSearchFilter
]

{ #category : #execution }
ApiQueryBuilder >> fetchGroups: aGtSearchFilter ofCourse: anInteger [ 
	| apiGroup groups |
	apiGroup := ApiGroup forToken: self token.
	apiGroup subscribeToCancel: self cancellation.
	groups := (apiGroup groupsOfCourse: anInteger) toArray wait
				select: aGtSearchFilter
				thenCollect: #id.
	^apiGroup groupMembers: groups.
]

{ #category : #utilities }
ApiQueryBuilder >> fetchUsers: aGtSearchFilter [ 
	| apiUser dict  |
	dict := Dictionary new.
	apiUser := ApiUser forToken: self token.
	apiUser subscribeToCancel: self cancellation.
	{'email'. 'id'. 'username'. 'auth'. 'firstname'. 'lastname'}
		do: [ :item | 
			| byQuery |
			byQuery := aGtSearchFilter value: ('moodleuser_' , item) asSymbol.
			byQuery isArray
				ifTrue: [ byQuery ifEmpty: [ ^ {} asAsyncStream ].
				dict at: item put: byQuery first ]].
	^dict ifEmpty: [apiUser completeUsers] ifNotEmpty:
		 [apiUser completeUsers: dict]
	
]

{ #category : #execution }
ApiQueryBuilder >> preload: aGtSearchFilter [
	| userQuery courseQuery filters res groupQuery courses |
	
	filters := { {aGtSearchFilter} asAsyncStream } asOrderedCollection.
	courseQuery := aGtSearchFilter value: MoodleCourse new.
	userQuery := aGtSearchFilter value: MoodleUser new.
	groupQuery := aGtSearchFilter value: MoodleGroup new.
	


	GtJustContextStackSignal emit.

	[
	courses := (self fetchCourses: aGtSearchFilter) cached.
	courseQuery ~= #pass
		ifTrue: [ 
			filters add: 
			(courses
					collect: [ :anItem | 
						self class fetchRule: {#courseid} select: anItem id ] )].
						
	groupQuery ~= #pass 
		ifTrue: [
			| groups |
			groups :=
				courses flatCollect: [:each |
					(self fetchGroups: aGtSearchFilter ofCourse: each id)
				].
			filters add: 
				(groups collect: [:each | 
					self class fetchRule: {#userid} select: each id
				])
		].
						
	userQuery ~= #pass
		ifTrue: [
			filters add: 
			((self fetchUsers: aGtSearchFilter) cached
					collect: [ :anItem |
						self class fetchRule: {#userid} select: anItem id ])]] on: Error do: [ :anError | 
		self cancellation cancel: anError.
		^ {} asAsyncStream
		].
	
	res := filters reduce: [:xs :ys | 
		xs
		 flatCollect: [ :x |
					ys asyncSimilarCopy map: [ :y | x & y ]]
	].
	
	GtJustContextStackSignal emit.

	^ res asAsyncStream
]

{ #category : #execution }
ApiQueryBuilder >> preloaded: aGtSearchFilter [ 
	^ aGtSearchFilter distributeAsync flatCollect: [ :aQuery | self preload: aQuery ]
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
