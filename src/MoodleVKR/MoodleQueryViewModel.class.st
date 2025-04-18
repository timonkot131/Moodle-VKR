Class {
	#name : #MoodleQueryViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'title',
		'itemsModels',
		'cancellation',
		'queryBuilder'
	],
	#category : #'MoodleVKR-ViewModels'
}

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> addQuery [
	| availableFilters itemsModel |
	availableFilters := MoodleAvailableFiltersBuilder new
			sourceQueryBuilder: ApiQueryBuilder.
	itemsModel := ConjFilterItemsModel new
			availableFiltersBuilder: availableFilters.
	
	self itemsModels: itemsModels, {#&. itemsModel}
]

{ #category : #announcer }
MoodleQueryViewModel >> announcer [
	<return: #Announcer>
	^ announcer 
]

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> at: anInteger [
^itemsModels at: anInteger
]

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> at: index put: value [
itemsModels at: index put: value.
self announce: MoodleQueryModelChanged new; getItems.
]

{ #category : #accessing }
MoodleQueryViewModel >> cancellation [
	^ cancellation
]

{ #category : #accessing }
MoodleQueryViewModel >> cancellation: aQueryCancellation [
	cancellation ifNotNil: [
		cancellation unsubscribe: self.
	].
	cancellation := aQueryCancellation.
	cancellation weak when: MoodleCancelEvent send: #onCancel: to: self
]

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> getItems [
	| count searchFilter result |
	count := (itemsModels
			reject: #isSymbol
			thenCollect: [ :item | item items size ])
			ifEmpty: [ ^ self ]
			ifNotEmpty: [ :items | items reduce: [ :x :y | x + y ] ].
	count isZero ifTrue: [ ^ self ]. 
	searchFilter := self reducedItems asSearchFilter. 
	self cancellation cancel.
	self cancellation: QueryCancellation new.
	self queryBuilder cancellation: self cancellation.
	result := self queryBuilder execute: searchFilter.
	self announce: (MoodleQueryValueChanged new items: result).
]

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> ids [ 
^1 to: itemsModels size.
]

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> initialize [
	| availableFilters itemsModel |
	super initialize.
	
	self cancellation: QueryCancellation new.
	self queryBuilder: (ApiQueryBuilder token: MConfig token cancellation: self cancellation).
	
	announcer := Announcer new.
	availableFilters := MoodleAvailableFiltersBuilder new
			sourceQueryBuilder: ApiQueryBuilder.
	itemsModel := ConjFilterItemsModel new
			availableFiltersBuilder: availableFilters.
	itemsModels := {itemsModel}.
]

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> isSingle [ 
^ itemsModels size ~= 1
]

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> itemsModels: anArray [ 
	itemsModels := anArray.
	self announce: MoodleQueryModelChanged new.
]

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> makeFiler: aReceiverObject message: aSymbol argument: anObject [
	(aReceiverObject isEmpty and: [anObject isEmpty]) 
		ifTrue: [  ^ConjFilterItemsModel new].
	aReceiverObject isEmpty ifTrue: [^anObject asSearchFilter].
	anObject isEmpty ifTrue: [^aReceiverObject asSearchFilter].
^aReceiverObject asSearchFilter perform: aSymbol withArguments: {anObject asSearchFilter}

]

{ #category : #accessing }
MoodleQueryViewModel >> onCancel: anObject [
self announce: anObject.
]

{ #category : #accessing }
MoodleQueryViewModel >> queryBuilder [
	^ queryBuilder
]

{ #category : #accessing }
MoodleQueryViewModel >> queryBuilder: anObject [
	queryBuilder := anObject
]

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> reducedItems [
	^itemsModels
		reduce: [ :x :y | 
			y isSymbol
				ifTrue: [[ :z | self makeFiler: x message: y argument: z ]]
				ifFalse: [ x value: y ] ]
]

{ #category : #'instace creation' }
MoodleQueryViewModel >> remove: anInteger [
	self assert: (itemsModels size > 1).
	itemsModels at: anInteger put: #toReject.
	(1 to: itemsModels size - 1)
			withIndexDo: [ :_ :index | 
				| x1 x2 |
				x1 := itemsModels at: index.
				x2 := itemsModels at: index + 1.
				(x1 isSymbol and: [ x2 isSymbol ])
					ifTrue: [ itemsModels at: index put: nil.
						itemsModels at: index + 1 put: nil ] ].
	self itemsModels: (itemsModels reject: #isNil)
]

{ #category : #'as yet unclassified' }
MoodleQueryViewModel >> title: aString [ 
	title = aString ifTrue: [^self].
    title := aString.
	self announce: (MoodleQueryTitleChangedEvent new title: title).
	 
]
