Class {
	#name : #MoodleEventQuery,
	#superclass : #Object,
	#category : #'MoodleVKR-Model'
}

{ #category : #static }
MoodleEventQuery class >> auths [
^#('cas' 'db' 'email' 'ldap' 'lti' 'manual' 'mnet' 'nologin' 'none' 'oauth2' 'shibboleth' 'webservice')
]

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

{ #category : #static }
MoodleEventQuery class >> contextLevels [
	^ Dictionary new
		at: 'Система' put: 10;
		at: 'Пользователь' put: 30;
		at: 'Категория курса' put: 40;
		at: 'Курс' put: 50;
		at: 'Модуль' put: 70;
		at: 'Блок' put: 80;
		yourself
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
^ #('\core\event\mycourses_viewed' '\core\event\enrol_instance_created' '\core\event\course_section_created' '\core\event\capability_assigned' '\mod_quiz\event\course_module_viewed' '\core\event\config_log_created' '\core\event\dashboard_viewed' '\core\event\course_category_viewed' '\core_reportbuilder\event\report_updated' '\tool_capability\event\report_viewed' '\core\event\url_blocked' '\core\event\course_viewed' '\core_reportbuilder\event\report_created'
'\assignsubmission_comments\event\comment_created' '\assignsubmission_comments\event\comment_deleted' '\assignsubmission_file\event\assessable_uploaded' '\assignsubmission_file\event\submission_created' '\assignsubmission_file\event\submission_updated' '\assignsubmission_onlinetext\event\assessable_uploaded' '\assignsubmission_onlinetext\event\submission_created' '\assignsubmission_onlinetext\event\submission_updated' '\block_comments\event\comment_created' '\block_comments\event\comment_deleted' '\booktool_exportimscp\event\book_exported' '\booktool_print\event\book_printed' '\booktool_print\event\chapter_printed' '\core\event\assessable_submitted' '\core\event\assessable_uploaded' '\core\event\base' '\core\event\blog_association_created' '\core\event\blog_comment_created' '\core\event\blog_comment_deleted' '\core\event\blog_entries_viewed' '\core\event\blog_entry_created' '\core\event\blog_entry_deleted' '\core\event\blog_entry_updated' '\core\event\cohort_created' '\core\event\cohort_deleted' '\core\event\cohort_member_added' '\core\event\cohort_member_removed' '\core\event\cohort_updated' '\core\event\comment_created' '\core\event\comment_deleted' '\core\event\comments_viewed' '\core\event\content_viewed' '\core\event\course_category_created' '\core\event\course_category_deleted' '\core\event\course_category_updated' '\core\event\course_completed' '\core\event\course_completion_updated' '\core\event\course_content_deleted' '\core\event\course_created' '\core\event\course_deleted' '\core\event\course_module_completion_updated' '\core\event\course_module_created' '\core\event\course_module_deleted' '\core\event\course_module_instance_list_viewed' '\core\event\course_module_instances_list_viewed' '\core\event\course_module_updated' '\core\event\course_module_viewed' '\core\event\course_reset_ended' '\core\event\course_reset_started' '\core\event\course_restored' '\core\event\course_section_updated' '\core\event\course_updated' '\core\event\email_failed' '\core\event\group_created' '\core\event\group_deleted' '\core\event\group_member_added' '\core\event\group_member_removed' '\core\event\group_updated' '\core\event\grouping_created' '\core\event\grouping_deleted' '\core\event\grouping_updated' '\core\event\manager' '\core\event\mnet_access_control_created' '\core\event\mnet_access_control_updated' '\core\event\note_created' '\core\event\note_deleted' '\core\event\note_updated' '\core\event\notes_viewed' '\core\event\role_allow_assign_updated' '\core\event\role_allow_override_updated' '\core\event\role_allow_switch_updated' '\core\event\role_assigned' '\core\event\role_capabilities_updated' '\core\event\role_deleted' '\core\event\role_unassigned' '\core\event\user_created' '\core\event\user_deleted' '\core\event\user_password_updated' '\core\event\user_enrolment_created' '\core\event\user_enrolment_deleted' '\core\event\user_enrolment_updated' '\core\event\user_list_viewed' '\core\event\user_loggedin' '\core\event\user_loggedinas' '\core\event\user_loggedout' '\core\event\user_login_failed' '\core\event\user_profile_viewed' '\core\event\user_updated' '\core\event\webservice_function_called' '\core\event\webservice_login_failed' '\core\event\webservice_service_created' '\core\event\webservice_service_deleted' '\core\event\webservice_service_updated' '\core\event\webservice_service_user_added' '\core\event\webservice_service_user_removed' '\core\event\webservice_token_created' '\core\event\webservice_token_sent' '\logstore_legacy\event\legacy_logged' '\mod_assign\event\all_submissions_downloaded' '\mod_assign\event\assessable_submitted' '\mod_assign\event\extension_granted' '\mod_assign\event\identities_revealed' '\mod_assign\event\marker_updated' '\mod_assign\event\statement_accepted' '\mod_assign\event\submission_created' '\mod_assign\event\submission_duplicated' '\mod_assign\event\submission_graded' '\mod_assign\event\submission_locked' '\mod_assign\event\submission_status_updated' '\mod_assign\event\submission_unlocked' '\mod_assign\event\submission_updated' '\mod_assign\event\workflow_state_updated' '\mod_book\event\chapter_created' '\mod_book\event\chapter_deleted' '\mod_book\event\chapter_updated' '\mod_book\event\chapter_viewed' '\mod_book\event\course_module_instance_list_viewed' '\mod_book\event\course_module_viewed' '\mod_chat\event\course_module_instance_list_viewed' '\mod_chat\event\message_sent' '\mod_chat\event\sessions_viewed' '\mod_choice\event\answer_submitted' '\mod_choice\event\answer_updated' '\mod_choice\event\course_module_instance_list_viewed' '\mod_choice\event\course_module_viewed' '\mod_choice\event\report_viewed' '\mod_data\event\comment_created' '\mod_data\event\comment_deleted' '\mod_data\event\course_module_instance_list_viewed' '\mod_data\event\course_module_viewed' '\mod_data\event\field_created' '\mod_data\event\field_deleted' '\mod_data\event\field_updated' '\mod_data\event\record_created' '\mod_data\event\record_deleted' '\mod_data\event\record_updated' '\mod_data\event\template_updated' '\mod_data\event\template_viewed' '\mod_feedback\event\course_module_instance_list_viewed' '\mod_feedback\event\course_module_viewed' '\mod_feedback\event\response_deleted' '\mod_feedback\event\response_submitted' '\mod_folder\event\course_module_instance_list_viewed' '\mod_folder\event\course_module_viewed' '\mod_folder\event\folder_updated' '\mod_forum\event\assessable_uploaded' '\mod_forum\event\course_module_instance_list_viewed' '\mod_forum\event\course_searched' '\mod_forum\event\discussion_created' '\mod_forum\event\discussion_deleted' '\mod_forum\event\discussion_moved' '\mod_forum\event\discussion_updated' '\mod_forum\event\discussion_viewed' '\mod_forum\event\forum_viewed' '\mod_forum\event\post_created' '\mod_forum\event\post_deleted' '\mod_forum\event\post_updated' '\mod_forum\event\readtracking_disabled' '\mod_forum\event\readtracking_enabled' '\mod_forum\event\subscribers_viewed' '\mod_forum\event\subscription_created' '\mod_forum\event\subscription_deleted' '\mod_forum\event\userreport_viewed' '\mod_glossary\event\comment_created' '\mod_glossary\event\comment_deleted' '\mod_lesson\event\course_module_instance_list_viewed' '\mod_lesson\event\course_module_viewed' '\mod_lesson\event\essay_assessed' '\mod_lesson\event\essay_attempt_viewed' '\mod_lesson\event\highscore_added' '\mod_lesson\event\highscores_viewed' '\mod_lesson\event\lesson_ended' '\mod_lesson\event\lesson_started' '\mod_lti\event\course_module_instance_list_viewed' '\mod_lti\event\course_module_viewed' '\mod_lti\event\unknown_service_api_called' '\mod_page\event\course_module_instance_list_viewed' '\mod_page\event\course_module_viewed' '\mod_quiz\event\attempt_abandoned' '\mod_quiz\event\attempt_becameoverdue' '\mod_quiz\event\attempt_started' '\mod_quiz\event\attempt_submitted' '\mod_resource\event\course_module_instance_list_viewed' '\mod_resource\event\course_module_viewed' '\mod_scorm\event\attempt_deleted' '\mod_scorm\event\course_module_instance_list_viewed' '\mod_scorm\event\course_module_viewed' '\mod_scorm\event\interactions_viewed' '\mod_scorm\event\report_viewed' '\mod_scorm\event\sco_launched' '\mod_scorm\event\tracks_viewed' '\mod_scorm\event\user_report_viewed' '\mod_url\event\course_module_instance_list_viewed' '\mod_url\event\course_module_viewed' '\mod_wiki\event\comment_created' '\mod_wiki\event\comment_deleted' '\mod_wiki\event\comments_viewed' '\mod_wiki\event\course_module_instance_list_viewed' '\mod_wiki\event\course_module_viewed' '\mod_wiki\event\page_created' '\mod_wiki\event\page_deleted' '\mod_wiki\event\page_diff_viewed' '\mod_wiki\event\page_history_viewed' '\mod_wiki\event\page_locks_deleted' '\mod_wiki\event\page_map_viewed' '\mod_wiki\event\page_updated' '\mod_wiki\event\page_version_deleted' '\mod_wiki\event\page_version_restored' '\mod_wiki\event\page_version_viewed' '\mod_wiki\event\page_viewed' '\mod_workshop\event\assessable_uploaded' '\mod_workshop\event\assessment_evaluated' '\mod_workshop\event\assessment_evaluations_reset' '\mod_workshop\event\assessment_reevaluated' '\mod_workshop\event\course_module_viewed' '\mod_workshop\event\instances_list_viewed' '\mod_workshop\event\phase_switched' '\mod_workshop\event\submission_assessed' '\mod_workshop\event\submission_created' '\mod_workshop\event\submission_reassessed' '\mod_workshop\event\submission_updated' '\mod_workshop\event\submission_viewed' '\report_log\event\content_viewed' '\report_loglive\event\content_viewed' '\report_outline\event\content_viewed' '\report_participation\event\content_viewed' '\report_stats\event\content_viewed' '\')
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
 {#contextlevel}.
 {MoodleUser. #auth}.
 {MoodleUser. #firstname}.
 {MoodleUser. #lastname}.
 {MoodleUser. #username}.
 {MoodleUser. #email}.
 {MoodleUser. #id}.
 {MoodleCourse. #fullname}.
 {MoodleCourse. #id}.
 {MoodleCourse. #category}.
 {MoodleCourse. #shortname}.
 {MoodleCourse. MoodleGroup. #name}.
 "{MoodleCourse. MoodleQuiz. #name}.
 {MoodleCourse. MoodleQuiz. MoodleAttempt. #id}"
} 
]
