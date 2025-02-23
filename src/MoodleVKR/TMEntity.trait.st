Trait {
	#name : #TMEntity,
	#category : #'MoodleVKR-Model'
}

{ #category : #accessing }
TMEntity >> accept: aVisitor [
	aVisitor visitEntity: self.
	self class pragmas
		select: [ :aPragma | aPragma selector = #delegate: ]
		thenDo: [ :aPragma | 
			| delegate |
			delegate := aPragma arguments first asClass new.
			delegate delegatedMethod: aPragma method.
			delegate accept: aVisitor ]
]
