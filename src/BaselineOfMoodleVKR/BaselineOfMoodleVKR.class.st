Class {
	#name : #BaselineOfMoodleVKR,
	#superclass : #BaselineOf,
	#category : #BaselineOfMoodleVKR
}

{ #category : #loading }
BaselineOfMoodleVKR class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'Moodle-VKR' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfMoodleVKR >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'MoodleVKR'
		]
]
