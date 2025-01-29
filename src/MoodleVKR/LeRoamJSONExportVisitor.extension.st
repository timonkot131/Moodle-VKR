Extension { #name : #LeRoamJSONExportVisitor }

{ #category : #'*MoodleVKR' }
LeRoamJSONExportVisitor >> visitExampleSnippet: arg1 [
	^ String
		streamContents: [ :arg2 | 
			arg2
				<< '```';
				cr;
				<< arg1 contentAsString;
				cr;
				<< '```' ]
]
