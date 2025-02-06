Extension { #name : #MySQLDriverSpec }

{ #category : #'*MoodleVKR' }
MySQLDriverSpec >> dbDescription [
	<magritteDescription>
	^ MAStringDescription new
		label: 'Database';
		priority: 3;
		accessor: #db;
		editorAptitude:  [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ].
]

{ #category : #'*MoodleVKR' }
MySQLDriverSpec >> hostDescription [
<magritteDescription>
^ MAStringDescription new 
		label: 'Host';
		priority: 1;
		accessor: #host;
		editorAptitude:  [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ].
	
]

{ #category : #'*MoodleVKR' }
MySQLDriverSpec >> passwordDescription [
<magritteDescription>
	^ MAPasswordDescription new
		label: 'Password';
		priority: 5;
		accessor: #password;
		editorAptitude:  [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ].
]

{ #category : #'*MoodleVKR' }
MySQLDriverSpec >> portDescription [
<magritteDescription>
^ MANumberDescription new 
		label: 'Port';
		priority: 2;
		accessor: #port;
		editorAptitude:  [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ].
]

{ #category : #'*MoodleVKR' }
MySQLDriverSpec >> tryConnectAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 14;
		label: 'Проверить подключение';
		isLabelVisible: true;
		blocIcon: BrGlamorousVectorIcons accept;
		action: (GtMagritteAction new
				beInFutureProcess;
				beWithFutureResponse;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aMemento commit.
					aModel
					]);
		beAlwaysEnabled;
		beToolbarAction
]

{ #category : #'*MoodleVKR' }
MySQLDriverSpec >> userDescription [
<magritteDescription>
	^ MAStringDescription new
		label: 'User';
		priority: 4;
		accessor: #user;
		editorAptitude:  [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ].
]
