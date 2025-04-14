Class {
	#name : #MoodleAvailableFiltersBuilder,
	#superclass : #Object,
	#traits : 'TMQueryBuilder',
	#classTraits : 'TMQueryBuilder classTrait',
	#instVars : [
		'filterItemsModel',
		'sourceQueryBuilder'
	],
	#category : #'MoodleVKR-Filters - Model'
}

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleCourseCategory: aCompiledMethod [
<rule: #(MoodleCourse category)>
^GtFilterTextModel new 
	order: 30;
	name: 'Курс: Категория'
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleCourseFullname: aCompiledMethod [
<rule: #(MoodleCourse fullname)>
^GtFilterTextModel new 
	order: 30;
	name: 'Курс: Полное имя'
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleCourseShortname: aCompiledMethod [
<rule: #(MoodleCourse shortname)>
^GtFilterTextModel new 
	order: 30;
	name: 'Курс: Короткое имя'
	
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleGroupName: aCompiledMethod [
<rule: #(MoodleCourse MoodleGroup name)>
^GtFilterTextModel new 
	order: 31;
	name: 'Группа: Название'
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleQueryContextlevel: aCompiledMethod [
<rule: #(contextlevel)>
^MFilterShortListModel new 
	items: MoodleEventQuery contextLevels keys;
	selectedItem: 'Система';
	order: 10;
	name: 'Логи: Уровень контекста'.
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleQueryEventname: aCompiledMethod [
<rule: #(eventname)>
^GtFilterTextModel new 
	order: 10;
	name: 'Логи: Событие';
	completion: (MEventCompletionStrategy new)
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleQueryIp: aCompiledMethod [
<rule: #(ip)>
^GtFilterTextModel new 
	order: 10;
	name: 'Логи: IP'
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleQueryTimecreated: aCompiledMethod [
<rule: #(timecreated)>
^GtFilterTextModel new 
	order: 10;
	name: 'Логи: Время'. 
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleUserAuth: aCompiledMethod [
<rule: #(MoodleUser auth)>
^MFilterShortListModel new 
	items: MoodleEventQuery auths;
	selectedItem: 'manual';
	order: 20;
	name: 'Пользователь: Авторизация'
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleUserEmail: aCompiledMethod [
<rule: #(MoodleUser email)>
^GtFilterTextModel new 
	order: 20;
	name: 'Пользователь: Почта'
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleUserFirstname: aCompiledMethod [
<rule: #(MoodleUser firstname)>
^GtFilterTextModel new 
	order: 19;
	name: 'Пользователь: Имя'
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleUserLastname: aCompiledMethod [
<rule: #(MoodleUser lastname)>
^GtFilterTextModel new 
	order: 18;
	name: 'Пользователь: Фамилия'
]

{ #category : #query }
MoodleAvailableFiltersBuilder class >> moodleUserUsername: aCompiledMethod [
<rule: #(MoodleUser username)>
^GtFilterTextModel new 
	order: 20;
	name: 'Пользователь: Ник'
]

{ #category : #'as yet unclassified' }
MoodleAvailableFiltersBuilder class >> queryMethodSelector: selector class: class [ 
^(class first asLowercase asString, class copyWithoutFirst)
			, (selector first asUppercase asString, selector copyWithoutFirst)
			, ': aCompiledMethod' .
]

{ #category : #'as yet unclassified' }
MoodleAvailableFiltersBuilder >> availableFilters [
<return: #Collection of: #GtFilterModel>
| models |
	models := self class rules associations collect: [:pair |
	| compiledMethod filterModel sourceRules|
	sourceRules := self sourceQueryBuilder rules.
	compiledMethod := sourceRules at: pair key.
	filterModel := pair value valueWithReceiver: self class
				arguments: {compiledMethod}.
	filterModel creator: (CreateMethodBuilder from: compiledMethod)
 ].
 ^models sort: [:x :y | x order <= y order].
]

{ #category : #accessing }
MoodleAvailableFiltersBuilder >> filterItemsModel [
	^ filterItemsModel
]

{ #category : #accessing }
MoodleAvailableFiltersBuilder >> filterItemsModel: anObject [
	filterItemsModel := anObject
]

{ #category : #accessing }
MoodleAvailableFiltersBuilder >> sourceQueryBuilder [
	^ sourceQueryBuilder
]

{ #category : #accessing }
MoodleAvailableFiltersBuilder >> sourceQueryBuilder: aTMQueryBuilder [
	sourceQueryBuilder := aTMQueryBuilder
]
