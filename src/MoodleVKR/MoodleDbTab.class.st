Class {
	#name : #MoodleDbTab,
	#superclass : #BrTab,
	#instVars : [
		'magritteViewModel',
		'mainFrame',
		'editFrame',
		'tabViewModel',
		'accordion',
		'magritteElement',
		'sourceViewModel'
	],
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #'as yet unclassified' }
MoodleDbTab >> initialize [
	super initialize.
	mainFrame := BlElement new
			layout: BlLinearLayout vertical;
			padding: (BlInsets all: 10);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].

	accordion := BrAccordion new
 		  hMatchParent;
 		  		
			aptitude: BrGlamorousAccordionAptitude new;
			header: [ BrLabel new
					aptitude: BrGlamorousAccordionHeaderAptitude;
					text: 'Настройка соединения' ].


	editFrame := BlElement new
			layout: BlFrameLayout new;
			padding: (BlInsets all: 10);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].
				
	mainFrame addChild: accordion.
	mainFrame addChild: editFrame.

	self
		aptitude: BrGlamorousTabAptitude;
		padding: (BlInsets all: 10);
		label: 'Хранилище';
		stencil: [ mainFrame ]
]

{ #category : #'as yet unclassified' }
MoodleDbTab >> magritteViewModel: aGtMagritteViewModel [
	"Магритовая вьюмодель, Сделана не очень, так как приходится самому возиться с моделью внутри него, внутри клиента. Я думаю нужно создать обертку для этой вьюмодели"
	| element memento |
	magritteViewModel == aGtMagritteViewModel ifTrue: [ ^ self ].	"Удаление колбэков на на проверку соединения"
	self unsubscribeFromMagritte. 
	
	"Инициация формы с её Мементо, временным объектом для записи"
	element := aGtMagritteViewModel asElement.
	memento := aGtMagritteViewModel mementoFuture.

	"Переопределяем whenSuccess у элемента"
	element asyncFuture
		future: memento;
		whenSuccess: [ :theFrame :aMemento | 
			| actions |
			actions := aMemento magritteActions.
			actions first "Accept"
				onSuccessCallback: [  ].
			actions third "Проверка подключения"
				onSuccessCallback: [ :arg | self tryConnect: arg ].
			aGtMagritteViewModel initializeForm: theFrame forMemento: aMemento ].
	magritteElement := element.
	editFrame addChild: element.
	magritteViewModel := aGtMagritteViewModel	
		
]

{ #category : #'as yet unclassified' }
MoodleDbTab >> setAccordionText: aString withColor: aColor [
	accordion aptitude headerBar background: aColor.
	accordion
		header: [ BrLabel new
				aptitude: BrGlamorousAccordionHeaderAptitude;
				text: aString ].
]

{ #category : #accessing }
MoodleDbTab >> sourceViewModel [
	^ sourceViewModel
]

{ #category : #accessing }
MoodleDbTab >> sourceViewModel: anObject [
	sourceViewModel := anObject
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
	| connection |
	connection := ReStore connection: (SSWMySQLConnection new connectionSpec: spec).
	[ connection connect.
		 self setAccordionText: 'Соединение успешно' withColor: Color lightGreen .
		 self sourceViewModel setModel: connection
		 ]
		on: SocketError , MySQLNoConnectionError
		do: [ :str | 
			str messageText = 'Success'
				ifTrue: [ self setAccordionText: 'Соединение успешно' withColor: Color lightGreen .
				 self sourceViewModel setModel: connection
				]
				ifFalse: [ self setAccordionText: 'Ошибка соединения' withColor: Color red ] ]
]

{ #category : #'as yet unclassified' }
MoodleDbTab >> unsubscribeFromMagritte [
	magritteViewModel
		ifNotNil: [ :aViewModel | 
			| actions |
			actions := (magritteElement userData at: aViewModel class gtMementoSymbol) magritteActions.
			actions first onSuccessCallbacks removeAll.
			actions third
				onSuccessCallbacks removeAll.
			editFrame removeChildren ]
]
