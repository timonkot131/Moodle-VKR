Trait {
	#name : #TMQueryBuilder,
	#category : #'MoodleVKR-Model'
}

{ #category : #rules }
TMQueryBuilder classSide >> rules [
<return: #aDictionary of: #Collection to: #CompiledMethod>
	(self class pragmas collect: 
		[ :aPragma | 
			| anArgument |
			anArgument := MoodleEventQuery parseRule: aPragma arguments first.
			anArgument -> aPragma method.
			 ]) asDictionary
			
]

{ #category : #rules }
TMQueryBuilder >> argument: anObject for: aCollection [
self currentQueryArguments at: aCollection put: anObject.
]

{ #category : #rules }
TMQueryBuilder >> currentQueryArguments [
<return: #aDictionary of: #Collection to: #anObject>
	^self explicitRequirement
]
