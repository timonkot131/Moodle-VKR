Class {
	#name : #MoodleEventQuery,
	#superclass : #Object,
	#category : #'MoodleVKR-Model'
}

{ #category : #accessing }
MoodleEventQuery class >> bindMethod: anArray [
	^ anArray
		at: (anArray indexOf: anArray last)
			put: {(anArray last: 2) first.
					anArray last};
		yourself.
]

{ #category : #accessing }
MoodleEventQuery class >> computeAssociations: arr [
	| data |
	data := self describe: arr.
	data := data
			collect: [ :x | 
				(x sliceFrom: 1 to: x size - 1)
					, {QuerySelector forAssociation: x last sourceClass: self} ].
	^ self flatConnection: data
]

{ #category : #accessing }
MoodleEventQuery class >> computeAssociations: arr forClass: aTMQueryBuilder [
	| data |
	data := self describe: arr.
	data := data
			collect: [ :x | 
				(x sliceFrom: 1 to: x size - 1)
					, {QuerySelector forAssociation: x last sourceClass: aTMQueryBuilder} ].
	^ self flatConnection: data
]

{ #category : #accessing }
MoodleEventQuery class >> describe: arr [
	^ arr
		collect: [ :aCollection | 
			| x |
			x := {MoodleQuery} , aCollection.
			self bindMethod: x ]
]

{ #category : #static }
MoodleEventQuery class >> eventAliases [ 
{
	'ww' -> '21'
}
]

{ #category : #static }
MoodleEventQuery class >> events [
^ #('\core\event\mycourses_viewed' '\core\event\user_list_viewed' '\core\event\user_loggedin' '\core\event\enrol_instance_created' '\mod_url\event\course_module_viewed' '\core\event\course_section_created' '\core\event\email_failed' '\core\event\capability_assigned' '\mod_quiz\event\course_module_viewed' '\core\event\config_log_created' '\core\event\webservice_service_updated' '\core\event\dashboard_viewed' '\mod_resource\event\course_module_viewed' '\core\event\course_category_viewed' '\core_reportbuilder\event\report_updated' '\core\event\user_loggedinas' '\tool_capability\event\report_viewed' '\core\event\url_blocked' '\core\event\course_created' '\core\event\course_viewed' '\core\event\webservice_service_created' '\core\event\user_profile_viewed' '\core\event\user_updated' '\core\event\webservice_function_called' '\core\event\role_assigned' '\core_reportbuilder\event\report_created' '\core\event\blog_entries_viewed' '\core\event\user_enrolment_created' '\core\event\user_created')
]

{ #category : #accessing }
MoodleEventQuery class >> flatConnection: arr [
	| elems |
	elems := arr flatten asSet select: #isClass.
	^ elems
		flatCollect: [ :aClass | 
			arr
				select: [ :x | (x indexOf: aClass) ~= 0 ]
				thenCollect: [ :x | 
					| anIndex |
					anIndex := x indexOf: aClass.
					x sliceFrom: anIndex to: anIndex + 1 ] ]
]

{ #category : #rules }
MoodleEventQuery class >> parseRule: anArray [
	| aSplitted |
	aSplitted := (anArray splitOn: ' ') first.
	^ aSplitted
		collect: [ :aValue | 
			| aSymbol |
			aSymbol := aValue asSymbol.
			aSymbol first isUppercase 
				ifTrue: [ aSymbol asClass ] 
				ifFalse: [ aSymbol ] ]
]

{ #category : #rules }
MoodleEventQuery class >> ruleHierarchy [
"Просто имена для сообщений, описывающие иерархию запроса"
^{
 {#eventname}.
 {#ip}.
 {#timecreated}.
 {MoodleUser. #fullname}.
 {MoodleUser. #username}.
 {MoodleUser. #email}.
  {MoodleUser. #id}.
 {MoodleCourse. #fullname}.
 {MoodleCourse. #id}.
 {MoodleCourse. #category}.
 {MoodleCourse. #shortname}.
 {MoodleCourse. MoodleQuiz. #name}.
 {MoodleCourse. MoodleQuiz. MoodleAttempt. #id}
} 
]
