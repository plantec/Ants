"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
...
"
Class {
	#name : #TerrainVue,
	#superclass : #Object,
	#instVars : [
		'graphicLoop',
		'terrain',
		'locationNbFourmiliere',
		'locationNbProie',
		'locationNbPheromone',
		'locationHeure',
		'locationNbOeufs',
		'locationNbLarves',
		'locationNbNymphes',
		'locationNbAdultes',
		'locationDepot',
		'space',
		'mainScreen',
		'home'
	],
	#classInstVars : [
		'terrain'
	],
	#category : #'Ants-View'
}

{ #category : #'instance creation' }
TerrainVue class >> with: aTerrain [
	
	^ self new
		terrain: aTerrain;
		yourself.
	
]

{ #category : #private }
TerrainVue >> createInfoPanel: aParentBlElement [

	| infoPanel |
	infoPanel := BlElement new.
	infoPanel background: Color gray.
	infoPanel size: 800@200.
	infoPanel relocate: 0@400.
	infoPanel constraintsDo: [ :c |
		c maxHeight: 200.
		c horizontal matchParent. 
	].
	self flag:'Subscribe to the extent changes to update position of the infopanel when the parent element in resized, normaly it should be declared in the layout'.
	aParentBlElement addEventHandlerOn: BlElementExtentChangedEvent do: [ 
		infoPanel relocate: 0@((aParentBlElement size y) - 200).	
	]. 
	aParentBlElement addChild: infoPanel.

	"Ajout de l'heure à l'interface."
	infoPanel addChild: ((BlTextElement new
			  relocate: 50 @ 30;
			  background: Color transparent) text: 'Time :' asRopedText).
	locationHeure := BlTextElement new
		                 relocate: 50 @ 50;
		                 background: Color transparent;
		                 text: terrain heure asRopedText.
	infoPanel addChild: locationHeure.

	"Ajout du nombre de fourmilières à l'interface."
	infoPanel addChild: ((BlTextElement new
			  relocate: 50 @ 80;
			  background: Color transparent) text:
			 'Nombre de Fourmilières :' asRopedText).
	locationNbFourmiliere := BlTextElement new
		                         relocate: 50 @ 100;
		                         background: Color transparent;
		                         text: terrain nbFourmiliere asRopedText.
	infoPanel addChild: locationNbFourmiliere.

	infoPanel addChild: ((BlTextElement new
			  relocate: 100 @ 100;
			  background: Color transparent) text: 'Dépôt :' asRopedText).
	locationDepot := BlTextElement new
		                 relocate: 150 @ 100;
		                 background: Color transparent;
		                 text: terrain depot asRopedText.
	infoPanel addChild: locationDepot.


	"Ajout du nombre de proies à l'interface."
	infoPanel addChild: ((BlTextElement new
			  relocate: 50 @ 130;
			  background: Color transparent) text:
			 'Nombre de Proies :' asRopedText).
	locationNbProie := BlTextElement new
		                   relocate: 50 @ 150;
		                   background: Color transparent;
		                   text: terrain nbProie asRopedText.
	infoPanel addChild: locationNbProie.

	"Ajout du nombre de pheromones à l'interface."
	infoPanel addChild: ((BlTextElement new
			  relocate: 450 @ 130;
			  background: Color transparent) text:
			 'Nombre de Pheromones :' asRopedText).
	locationNbPheromone := BlTextElement new
		                       relocate: 450 @ 150;
		                       background: Color transparent;
		                       text: terrain nbPheromone asRopedText.
	infoPanel addChild: locationNbPheromone.

	"Ajout du nombre de fourmis à l'interface."
	infoPanel addChild: ((BlTextElement new
			  relocate: 450 @ 80;
			  background: Color transparent) text:
			 'Nombre de Fourmis :' asRopedText).

	infoPanel addChild: ((BlTextElement new
			  relocate: 450 @ 100;
			  background: Color transparent) text: 'Oeufs : ' asRopedText).
	locationNbOeufs := BlTextElement new
		                   relocate: 500 @ 100;
		                   background: Color transparent;
		                   text: terrain nbOeufs asRopedText.
	infoPanel addChild: locationNbOeufs.

	infoPanel addChild: ((BlTextElement new
			  relocate: 525 @ 100;
			  background: Color transparent) text: 'Larves : ' asRopedText).
	locationNbLarves := BlTextElement new
		                    relocate: 575 @ 100;
		                    background: Color transparent;
		                    text: terrain nbLarves asRopedText.
	infoPanel addChild: locationNbLarves.

	infoPanel addChild: ((BlTextElement new
			  relocate: 600 @ 100;
			  background: Color transparent) text: 'Nymphes : ' asRopedText).
	locationNbNymphes := BlTextElement new
		                     relocate: 675 @ 100;
		                     background: Color transparent;
		                     text: terrain nbNymphes asRopedText.
	infoPanel addChild: locationNbNymphes.

	infoPanel addChild: ((BlTextElement new
			  relocate: 700 @ 100;
			  background: Color transparent) text: 'Adultes : ' asRopedText).
	locationNbAdultes := BlTextElement new
		                     relocate: 760 @ 100;
		                     background: Color transparent;
		                     text: terrain nbAdultes asRopedText.
	infoPanel addChild: locationNbAdultes.
]

{ #category : #accessing }
TerrainVue >> graphicLoop [

	^ graphicLoop
]

{ #category : #accessing }
TerrainVue >> graphicLoop: anObject [

	graphicLoop := anObject
]

{ #category : #accessing }
TerrainVue >> home [

	^home
]

{ #category : #accessing }
TerrainVue >> mainScreen [

	^ mainScreen
]

{ #category : #accessing }
TerrainVue >> space [

	^ space
]

{ #category : #action }
TerrainVue >> start [

	| anthillCircle |
	space := BlSpace new.
	space title: 'Ground with 1 Anthill'.
	space extent: 800 @ 600.
	space show.

	mainScreen := BlElement new.
	mainScreen background: Color white.
	mainScreen constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent. 
	].	
	space addChild: mainScreen.

	home := BlElement new.
	home background: Color black.
	self flag:'Layout and margin not works, try to find the good way to propose 200px bottom margin'.
	home margin: (BlInsets bottom: 200).
	home constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent. 
	].	
	mainScreen addChild: home.

	anthillCircle := BlElement new
		             background: Color transparent;
		             border: (BlBorder paint: Color blue width: 1);
		             geometry: BlCircleGeometry new;
		             size: 200 @ 200;
		             relocate: terrain fourmiliere position - 100.
	mainScreen addChild: anthillCircle.

	self createInfoPanel: mainScreen.
	self startGraphicLoop
]

{ #category : #action }
TerrainVue >> startGraphicLoop [

	| tempChildren |
	graphicLoop ifNotNil: [ "Loop already started" ^self ].
	graphicLoop := ([ 
		[true] whileTrue: [ | startTimeInMs endTimeInMs waitingTimeInMs |
			startTimeInMs := Time now asMilliSeconds.
			self updateUI.
			tempChildren := self home children.
			tempChildren do: [ :temp | temp animation ].
			endTimeInMs := Time now asMilliSeconds.
			"60 fps correspond to ~16.6ms per frame"
			waitingTimeInMs := (16.6 - (endTimeInMs - startTimeInMs) max: 0.1). 
			waitingTimeInMs milliSecond wait.
		] 
	] forkAt: Processor userBackgroundPriority )
]

{ #category : #action }
TerrainVue >> stop [
	"stop all the simulation"

	self stopGraphicLoop
]

{ #category : #action }
TerrainVue >> stopGraphicLoop [

	graphicLoop ifNil:[^self].
	graphicLoop terminate.
	graphicLoop := nil.
]

{ #category : #accessing }
TerrainVue >> terrain [

	^ terrain
]

{ #category : #accessing }
TerrainVue >> terrain: aTerrain [

	terrain := aTerrain
]

{ #category : #action }
TerrainVue >> updateUI [
	
	"Mise à jour des données sur le time et les phéromones de l'interface."
	locationHeure text: (terrain heure asRopedText ).
	locationNbPheromone text: (terrain nbPheromone asRopedText ).
	
	"Si changegmeent d'une donnée mise à jour de la donnée dans l'interface."
	(locationNbFourmiliere text asString = terrain nbFourmiliere asString) ifFalse: [ locationNbFourmiliere text: (terrain nbFourmiliere asRopedText ). ].
	(locationDepot text asString  = terrain depot asString) ifFalse: [ locationDepot text: (terrain depot asRopedText ). ].
	(locationNbProie text asString = terrain nbProie asString) ifFalse: [ locationNbProie text: (terrain nbProie asRopedText ). ].
	(locationNbOeufs text asString = terrain nbOeufs asString) ifFalse: [ locationNbOeufs text: (terrain nbOeufs asRopedText ). ].
	(locationNbLarves text asString = terrain nbLarves asString) ifFalse: [ locationNbLarves text: (terrain nbLarves asRopedText ). ].
	(locationNbNymphes text asString = terrain nbNymphes asString) ifFalse: [ locationNbNymphes text: (terrain nbNymphes asRopedText ). ].
	(locationNbAdultes text asString = terrain nbAdultes asString) ifFalse: [ locationNbAdultes text: (terrain nbAdultes asRopedText ). ].
]
