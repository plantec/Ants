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
	#superclass : #BlElement,
	#instVars : [
		'terrain',
		'locationNbFourmiliere',
		'locationNbProie',
		'locationNbPheromone',
		'locationHeure',
		'locationNbOeufs',
		'locationNbLarves',
		'locationNbNymphes',
		'locationNbAdultes',
		'locationDepot'
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

{ #category : #action }
TerrainVue >> graphicLoop [

	| tempChildren |
	[ 
	1000 timesRepeat: [ 
		self actualiserInterface.
		tempChildren := terrain home children.
		tempChildren do: [ :temp | temp animation ].
		45 milliSecond wait ] ] fork
]

{ #category : #action }
TerrainVue >> start [

	"Ajout de l'heure à l'interface."
	terrain space addChild: ( (BlTextElement new relocate: 50@430) text: ('Time :' asRopedText )  ).
	locationHeure:= BlTextElement new 
							relocate: 50@450; text: (terrain heure asRopedText ) .
	terrain space addChild: locationHeure.
	
	"Ajout du nombre de fourmilières à l'interface."
	terrain space addChild: ( (BlTextElement new relocate: 50@480) text: ('Nombre de Fourmilières :' asRopedText )  ).
	locationNbFourmiliere:= BlTextElement new 
							relocate: 50@500; text: (terrain nbFourmiliere asRopedText ) .
	terrain space addChild: locationNbFourmiliere.
	
	terrain space addChild: ( (BlTextElement new relocate: 100@500) text: ('Dépôt :' asRopedText )  ).
	locationDepot:= BlTextElement new 
							relocate: 150@500; text: (terrain depot asRopedText ) .
	terrain space addChild: locationDepot.
	
	
	
	
	"Ajout du nombre de proies à l'interface."		
	terrain space addChild: ( (BlTextElement new relocate: 50@530) text: ('Nombre de Proies :' asRopedText )  ).			
	locationNbProie:= BlTextElement new 
					relocate: 50@550; text: (terrain nbProie asRopedText ) .
	terrain space addChild: locationNbProie.
	
	"Ajout du nombre de pheromones à l'interface."
	terrain space addChild: ( (BlTextElement new relocate: 450@530) text: ('Nombre de Pheromones :' asRopedText )  ).
	locationNbPheromone:= BlTextElement new 
					relocate: 450@550; text: (terrain nbPheromone asRopedText ) .
	terrain space addChild: locationNbPheromone.
	
	"Ajout du nombre de fourmis à l'interface."
	terrain space addChild: ( (BlTextElement new relocate: 450@480) text: ('Nombre de Fourmis :' asRopedText )  ).
	
	terrain space addChild: ( (BlTextElement new relocate: 450@500) text: ('Oeufs : ' asRopedText )  ).
	locationNbOeufs:= BlTextElement new 
					relocate: 500@500; text: (terrain nbOeufs asRopedText ) .
	terrain space addChild: locationNbOeufs.

	terrain space addChild: ( (BlTextElement new relocate: 525@500) text: ('Larves : ' asRopedText )  ).
	locationNbLarves := BlTextElement new 
					relocate: 575@500; text: (terrain nbLarves asRopedText ) .
	terrain space addChild: locationNbLarves.
	
	terrain space addChild: ( (BlTextElement new relocate: 600@500) text: ('Nymphes : ' asRopedText )  ).
	locationNbNymphes := BlTextElement new 
					relocate: 675@500; text: (terrain nbNymphes asRopedText ) .
	terrain space addChild: locationNbNymphes.
	
	terrain space addChild: ( (BlTextElement new relocate: 700@500) text: ('Adultes : ' asRopedText )  ).
	locationNbAdultes := BlTextElement new 
					relocate: 760@500; text: (terrain nbAdultes asRopedText ) .
	terrain space addChild: locationNbAdultes.
	
	self graphicLoop.
]

{ #category : #accessing }
TerrainVue >> terrain [

	^ terrain.
]

{ #category : #accessing }
TerrainVue >> terrain: aTerrain [

	terrain := aTerrain.
]
