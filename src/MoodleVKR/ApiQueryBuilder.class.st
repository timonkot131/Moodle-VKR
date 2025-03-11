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
ApiQueryBuilder class >> moodleQueryEventname: aSelected applyTo: anObject [
<rule: #(eventname)>
anObject class ~= SSWDBBlockArgument ifTrue: [^#pass].
^anObject eventname = aSelected
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserEmail: aSelected applyTo: aMoodleUser [
<rule: #(MoodleUser email)>
^aMoodleUser email = aSelected.
]

{ #category : #query }
ApiQueryBuilder class >> moodleUserId: aSelected applyTo: aMoodleUserOrSymbol [
<rule: #(MoodleUser id)>
^aMoodleUserOrSymbol id = aSelected
]

{ #category : #initialization }
ApiQueryBuilder class >> query: aGtSearchFilter token: aString [
^self new query: aGtSearchFilter; token: aString.
]

{ #category : #'as yet unclassified' }
ApiQueryBuilder >> acceptQuery: aBlock [
	query := aBlock.
]

{ #category : #rules }
ApiQueryBuilder >> argument: aBlock for: aCollection [
self currentQueryFilters at: aCollection put: aBlock.
]

{ #category : #utilites }
ApiQueryBuilder >> check: anObject [
(query value: anObject) = #pass ifTrue: 
	[^ #pass.]
	ifFalse: [^ query]
]

{ #category : #rules }
ApiQueryBuilder >> currentQueryFilters [
<return: #aDictionary of: #Collection to: #anObject>
	self currentQueryFilters
]

{ #category : #execution }
ApiQueryBuilder >> execute [
	| userQuery chunks |
	userQuery := self check: MoodleUser new.
	userQuery ~= #pass
		ifTrue: [ | users subQuery logs stream |
			users := (self fetchUsers select: query) cached.
			subQuery := users
					inject: MethodNullSearchFilter new
					into: [ :aQuery :anItem | aQuery | [ :x | x userid = anItem id ] ].
			logs := MoodleDBEventLog storedInstances select: query & subQuery wait.	"satisfying"
			stream := IteratorStream forPosStream: logs readStream.
			^ stream asAsyncStream
				collect: [ :log | 
					| user |
					user := (users asyncSimilarCopy select: [ :aUser | aUser id = log userid ]) next wait value.
					MoodleEventLog new
						user: user;
						eventName: log eventname;
						id: log id ] ]
		ifFalse: [ 
			| res stream users job|
			res := MoodleDBEventLog storedInstances select: query.
			stream := IteratorStream forPosStream: res readStream.
			chunks := (stream asAsyncStream chunks: 50) cached collect: [:logs | 
				|userids apiUser|
				apiUser := ApiUser forToken: token.
				userids := (logs collect: #userid) asSet. 
				job := (apiUser completeUsersChunk: userids) 
					inject: Dictionary new into: [:dic :user | dic at: user id put: user; yourself].
				users := job wait.
				(logs collect: [:log  |
					MoodleEventLog new
						user: (users at: log userid);
						eventName: log eventname;
						id: log id
				]) asAsyncStream
			].
			^chunks flatten
		 ]
]

{ #category : #'as yet unclassified' }
ApiQueryBuilder >> fetchUsers [
	| apiUser |
	apiUser := ApiUser forToken: token.
	{'email'. 'id'. 'username'}
		do: [ :item | 
			| byQuery |
			byQuery := query value: ('moodleuser_' , item) asSymbol.
			byQuery isArray
				ifTrue: [ byQuery ifEmpty: [ ^ {} ].
				^ apiUser completeUsersChunk: byQuery field: item ]].
	^apiUser completeUsers.
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
