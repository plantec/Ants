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
	#category : #Ants
}

{ #category : #'instance creation' }
TerrainVue class >> with: aTerrain [
	
	^ self new
		terrain: aTerrain;
		yourself.
	
]

{ #category : #action }
TerrainVue >> actualiserInterface [
	
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

	| monCercle |
	space := BlSpace new.
	space title: 'Terrain'.
	space extent: 800 @ 600.
	space root background: Color white.
	space show.

	mainScreen := BlElement new.
	mainScreen size: 800 @ 600.
	mainScreen background: Color gray.
	space addChild: mainScreen.

	home := BlElement new.
	home size: 800 @ 400.
	home background: Color black.
	mainScreen addChild: home.

	monCercle := BlElement new
		             background: Color transparent;
		             border: (BlBorder paint: Color blue width: 1);
		             geometry: BlCircleGeometry new;
		             size: 200 @ 200;
		             relocate: terrain fourmiliere position - 100.
	mainScreen addChild: monCercle.

	"Ajout de l'heure à l'interface."
	mainScreen addChild: ((BlTextElement new
			  relocate: 50 @ 430;
			  background: Color transparent) text: 'Time :' asRopedText).
	locationHeure := BlTextElement new
		                 relocate: 50 @ 450;
		                 background: Color transparent;
		                 text: terrain heure asRopedText.
	mainScreen addChild: locationHeure.

	"Ajout du nombre de fourmilières à l'interface."
	mainScreen addChild: ((BlTextElement new
			  relocate: 50 @ 480;
			  background: Color transparent) text:
			 'Nombre de Fourmilières :' asRopedText).
	locationNbFourmiliere := BlTextElement new
		                         relocate: 50 @ 500;
		                         background: Color transparent;
		                         text: terrain nbFourmiliere asRopedText.
	mainScreen addChild: locationNbFourmiliere.

	mainScreen addChild: ((BlTextElement new
			  relocate: 100 @ 500;
			  background: Color transparent) text: 'Dépôt :' asRopedText).
	locationDepot := BlTextElement new
		                 relocate: 150 @ 500;
		                 background: Color transparent;
		                 text: terrain depot asRopedText.
	mainScreen addChild: locationDepot.


	"Ajout du nombre de proies à l'interface."
	mainScreen addChild: ((BlTextElement new
			  relocate: 50 @ 530;
			  background: Color transparent) text:
			 'Nombre de Proies :' asRopedText).
	locationNbProie := BlTextElement new
		                   relocate: 50 @ 550;
		                   background: Color transparent;
		                   text: terrain nbProie asRopedText.
	mainScreen addChild: locationNbProie.

	"Ajout du nombre de pheromones à l'interface."
	mainScreen addChild: ((BlTextElement new
			  relocate: 450 @ 530;
			  background: Color transparent) text:
			 'Nombre de Pheromones :' asRopedText).
	locationNbPheromone := BlTextElement new
		                       relocate: 450 @ 550;
		                       background: Color transparent;
		                       text: terrain nbPheromone asRopedText.
	mainScreen addChild: locationNbPheromone.

	"Ajout du nombre de fourmis à l'interface."
	mainScreen addChild: ((BlTextElement new
			  relocate: 450 @ 480;
			  background: Color transparent) text:
			 'Nombre de Fourmis :' asRopedText).

	mainScreen addChild: ((BlTextElement new
			  relocate: 450 @ 500;
			  background: Color transparent) text: 'Oeufs : ' asRopedText).
	locationNbOeufs := BlTextElement new
		                   relocate: 500 @ 500;
		                   background: Color transparent;
		                   text: terrain nbOeufs asRopedText.
	mainScreen addChild: locationNbOeufs.

	mainScreen addChild: ((BlTextElement new
			  relocate: 525 @ 500;
			  background: Color transparent) text: 'Larves : ' asRopedText).
	locationNbLarves := BlTextElement new
		                    relocate: 575 @ 500;
		                    background: Color transparent;
		                    text: terrain nbLarves asRopedText.
	mainScreen addChild: locationNbLarves.

	mainScreen addChild: ((BlTextElement new
			  relocate: 600 @ 500;
			  background: Color transparent) text: 'Nymphes : ' asRopedText).
	locationNbNymphes := BlTextElement new
		                     relocate: 675 @ 500;
		                     background: Color transparent;
		                     text: terrain nbNymphes asRopedText.
	mainScreen addChild: locationNbNymphes.

	mainScreen addChild: ((BlTextElement new
			  relocate: 700 @ 500;
			  background: Color transparent) text: 'Adultes : ' asRopedText).
	locationNbAdultes := BlTextElement new
		                     relocate: 760 @ 500;
		                     background: Color transparent;
		                     text: terrain nbAdultes asRopedText.
	mainScreen addChild: locationNbAdultes.

	self startGraphicLoop
]

{ #category : #action }
TerrainVue >> startGraphicLoop [

	| tempChildren |
	graphicLoop ifNotNil: [ "Loop already started" ^self ].
	graphicLoop := ([ 
		[true] whileTrue: [ 
			self actualiserInterface.
			tempChildren := self home children.
			tempChildren do: [ :temp | temp animation ].
			60 milliSecond wait. 
		] 
	] fork)
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
