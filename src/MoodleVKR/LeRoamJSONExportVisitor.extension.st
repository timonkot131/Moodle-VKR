Extension { #name : #LeRoamJSONExportVisitor }

{ #category : #'*MoodleVKR' }
LeRoamJSONExportVisitor >> visitExampleSnippet: aSnippet [
	^ String streamContents: [:stream |
		stream 
			<< '```'; cr;
			<< aSnippet contentAsString; cr;
			<< '```'
	]
]
