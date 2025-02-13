"
Super memento explicitely writes nil to the field... This class is for fixing that.
"
Class {
	#name : #FixedMemento,
	#superclass : #GtMagritteMemento,
	#category : #'MoodleVKR-Utility'
}

{ #category : #'as yet unclassified' }
FixedMemento >> write: anObject using: aDescription [
	"must only be called in UI thread"

	<return: #TAsyncFuture>
	| anObservable aNewValue |
	anObservable := self readObservableValueUsing: aDescription.
	aNewValue := anObservable valueOrNil copyWithCurrentValue: anObject.
	
	aNewValue currentValue
		ifNil: [ aNewValue
				become: (GtMagritteValue new
						description: aDescription;
						currentValue: '';
						originalValue: aNewValue originalValue) ].
	anObservable value: aNewValue.



	^ (self validatorUsing: aDescription) observeNext next
]
