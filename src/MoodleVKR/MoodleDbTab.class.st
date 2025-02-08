Class {
	#name : #MoodleDbTab,
	#superclass : #BrTab,
	#instVars : [
		'magritteViewModel',
		'mainFrame',
		'editFrame',
		'tabViewModel'
	],
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #'as yet unclassified' }
MoodleDbTab >> initialize [
	super initialize.
	mainFrame := BlElement new
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].

	editFrame := BlElement new
			layout: BlFrameLayout new;
			constraintsDo: [ :c | 
			
				c horizontal fitContent.
				c vertical fitContent ].
	
 
	
	
	
	self
		aptitude: BrGlamorousTabAptitude;
		label: 'Хранилище';
		stencil: [editFrame]
]

{ #category : #'as yet unclassified' }
MoodleDbTab >> magritteViewModel: aGtMagritteViewModel [
	"Магритовая вьюмодель, Сделана не очень, так как приходится самому возиться с моделью внутри него, внутри клиента. Я думаю нужно создать обертку для этой вьюмодели"

	| element memento |
	magritteViewModel == aGtMagritteViewModel ifTrue: [ ^ self ].	"Удаление колбэков на на проверку соединения"
	magritteViewModel
		ifNotNil: [ :vm | 
			editFrame removeChildren.
			(vm asElement userData at: vm gtMementoSymbol) magritteActions third
				onSuccessCallbacks removeAll ].	
	"Инициация формы с её Мементо, временным объектом для записи"
	element := aGtMagritteViewModel asElement.
	memento := aGtMagritteViewModel mementoBlock value.
	element userData at: GtMagritteViewModel gtMementoSymbol put: memento.
	editFrame addChild: element.
	magritteViewModel := aGtMagritteViewModel.
	memento magritteActions third
			onSuccessCallback: [ :arg | self tryConnect: arg ]
]

{ #category : #'as yet unclassified' }
MoodleDbTab >> subscribeToViewModel [

]

{ #category : #'api - style' }
MoodleDbTab >> tabViewModel: aViewModel [
	tabViewModel == aViewModel ifTrue: [^self].
	tabViewModel ifNotNil: [
		tabViewModel unsubscribe: self.
	]. 
	tabViewModel := aViewModel.

self subscribeToViewModel.
]

{ #category : #'as yet unclassified' }
MoodleDbTab >> tryConnect: spec [
	[ ReStore
		connection: (SSWMySQLConnection new connectionSpec: spec);
		connect ]
		on: SocketError
		do: [ :str | 
			str messageText = 'Success'
				ifTrue: [ 'connection successful' traceCr ]
				ifFalse: [ 'connection error' traceCr ] ]
]
