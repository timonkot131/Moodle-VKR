Extension { #name : #BrTextEditorModel }

{ #category : #'*MoodleVKR' }
BrTextEditorModel >> removeEvent: anEvent [
	^ self removeEventHandlersSuchThat: [ :x | x eventClass = anEvent ]
]

{ #category : #'*MoodleVKR' }
BrTextEditorModel >> replaceWith: aString [
"Calls Modified event two times"
self deleter from: 0 to: self text size; delete.
self inserter atEnd; string: aString; insert.
]
