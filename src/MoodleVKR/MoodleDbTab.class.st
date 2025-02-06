Class {
	#name : #MoodleDbTab,
	#superclass : #BrTab,
	#instVars : [
		'viewModel',
		'magritteViewModel'
	],
	#category : #'MoodleVKR-MoodleApp'
}

{ #category : #'as yet unclassified' }
MoodleDbTab >> initialize [ 
self aptitude: BrGlamorousTabAptitude; 
	label: 'Хранилище'.
	

]

{ #category : #'as yet unclassified' }
MoodleDbTab >> magritteViewModel: aGtMagritteViewModel [
	"Магритовая вьюмодель, Сделана не очень, так как приходится самому возиться с моделью внутри него, внутри клиента. Я думаю нужно создать обертку для этой вьюмодели"

	| element memento |
	magritteViewModel == aGtMagritteViewModel ifTrue: [ ^ self ].	"Удаление колбэков на на проверку соединения"
	magritteViewModel
		ifNotNil: [ :vm | 
			(vm asElement userData at: vm gtMementoSymbol) magritteActions third
				onSuccessCallbacks removeAll ].	
	"Инициация формы с её Мементо, временным объектом для записи"
	element := aGtMagritteViewModel asElement.
	memento := aGtMagritteViewModel mementoBlock value.
	element userData at: GtMagritteViewModel gtMementoSymbol put: memento.
	magritteViewModel := aGtMagritteViewModel.
	magritteViewModel memento magritteActions third
			onSuccessCallback: [ :arg | self tryConnect: arg ]
]

{ #category : #'as yet unclassified' }
MoodleDbTab >> subscribeToViewModel [

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

{ #category : #'as yet unclassified' }
MoodleDbTab >> viewModel: aViewModel [
	viewModel == aViewModel ifTrue: [^self].
	viewModel ifNotNil: [
		viewModel unsubscribe: self.
	].
	viewModel := aViewModel.

self subscribeToViewModel.
]
