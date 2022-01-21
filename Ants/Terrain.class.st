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

    Instance Variables
	entites:		<Object>
	home:		<Object>
	maxsize:		<Object>


    Implementation Points
...
"
Class {
	#name : #Terrain,
	#superclass : #Object,
	#instVars : [
		'entites',
		'proies',
		'pheromones',
		'fourmiliere',
		'home',
		'heure',
		'nbFourmiliere',
		'nbProie',
		'nbPheromone',
		'nbOeufs',
		'nbLarves',
		'nbNymphes',
		'nbAdultes',
		'mainScreen',
		'space'
	],
	#category : #Ants
}

{ #category : #initialization }
Terrain class >> simulation [
	| monTerrain |
	
	monTerrain := self new.
	monTerrain mainLoop.
	^ monTerrain.
]

{ #category : #adding }
Terrain >> addFourmis [

	| maFourmis maFourmisVue |
	maFourmis := Fourmis in: self at: fourmiliere hour: heure.
	entites add: maFourmis.
	maFourmisVue := EntiteVue with: maFourmis as: 3.
	home addChild: maFourmisVue.
	nbOeufs := nbOeufs + 1
]

{ #category : #adding }
Terrain >> addPheromone: anEntite [

	| monEntite monEntiteVue |
	monEntite := Pheromone in: self at: anEntite position hour: heure.
	pheromones add: monEntite.
	monEntiteVue := EntiteVue with: monEntite as: 2.
	home addChild: monEntiteVue.
	nbPheromone := nbPheromone + 1
]

{ #category : #adding }
Terrain >> addProie [

	| monEntite monEntiteVue |
	monEntite := Proie new: self.
	proies add: monEntite.
	monEntiteVue := EntiteVue with: monEntite as: 1.
	home addChild: monEntiteVue.
	nbProie := nbProie + 1
]

{ #category : #adding }
Terrain >> addProieAuDepot: aProie [

		"Ajoue du poids de la proie ramener au Depot."
		fourmiliere addToDepot: aProie.
		self deleteProie: aProie.
]

{ #category : #deleting }
Terrain >> deleteEntite: anEntite [

	entites remove: anEntite.

	home children do: [ :temp | 
		temp myEntite = anEntite ifTrue: [ home removeChild: temp ] ].

	(anEntite monStade isAdulte)
		ifFalse: [ nbLarves := nbLarves - 1 ];
		ifTrue: [ nbAdultes := nbAdultes - 1 ]
]

{ #category : #deleting }
Terrain >> deletePheromone: aPheromone [

	pheromones remove: aPheromone.

	home children do: [ :temp | 
		temp myEntite = aPheromone ifTrue: [ home removeChild: temp ] ].

	nbPheromone := nbPheromone - 1
]

{ #category : #deleting }
Terrain >> deleteProie: aProie [

	proies remove: aProie.

	home children do: [ :temp | 
		temp myEntite = aProie ifTrue: [ home removeChild: temp ] ].

	nbProie := nbProie - 1
]

{ #category : #accessing }
Terrain >> depot [

	^ fourmiliere depot
]

{ #category : #accessing }
Terrain >> fourmiliere [

	^ fourmiliere
]

{ #category : #accessing }
Terrain >> heure [

	^ heure
]

{ #category : #accessing }
Terrain >> home [

	^ home
]

{ #category : #initialization }
Terrain >> initialize [

	| monEntite monEntiteVue |
	super initialize.

	nbPheromone := 0.
	nbProie := 0.
	nbFourmiliere := 0.
	nbOeufs := 0.
	nbLarves := 0.
	nbNymphes := 0.
	nbAdultes := 0.
	heure := 0.
	entites := OrderedCollection new.
	proies := OrderedCollection new.
	pheromones := OrderedCollection new.
	
	"Ajout de la première fourmilière."
	monEntite := Fourmiliere new: self.
	fourmiliere := monEntite.
	
	self startGraphicAnimation.
		
	"Ajout de la première fourmilière."
	
	monEntiteVue := EntiteVue with: monEntite as: 0.
	home addChild: monEntiteVue.
	nbFourmiliere := nbFourmiliere + 1.

	1 to: 10 do: [ :i | 
		monEntite := Proie new: self.
		proies add: monEntite.
		monEntiteVue := EntiteVue with: monEntite as: 1.
		home addChild: monEntiteVue.
		nbProie := nbProie + 1 ].


]

{ #category : #action }
Terrain >> mainLoop [

	| message |
	[ 
	[ true ] whileTrue: [ "Action sur le fourmilière."
		message := fourmiliere action: heure.

		"Apparition de nouvelles proies."
		heure % 100 = 0 ifTrue: [ self addProie ].

		"Action sur les proies du terrain."
		proies do: [ :temp | temp ifNotNil: [ temp action: heure ] ].

		"Action sur les fourmis du terrain."
		entites do: [ :temp | temp ifNotNil: [ temp action: heure ] ].

		"Action sur les pheromones du terrain."
		pheromones do: [ :temp | temp ifNotNil: [ temp action: heure ] ].

		heure := heure + 1.
		50 milliSecond wait ] ] fork
]

{ #category : #adding }
Terrain >> mainScreen [

	^mainScreen
]

{ #category : #accessing }
Terrain >> nbAdultes [

	^ nbAdultes
]

{ #category : #accessing }
Terrain >> nbFourmiliere [

	^ nbFourmiliere
]

{ #category : #accessing }
Terrain >> nbLarves [

	^ nbLarves
]

{ #category : #accessing }
Terrain >> nbNymphes [

	^ nbNymphes
]

{ #category : #accessing }
Terrain >> nbOeufs [

	^ nbOeufs
]

{ #category : #accessing }
Terrain >> nbPheromone [

	^ nbPheromone
]

{ #category : #accessing }
Terrain >> nbProie [

	^ nbProie
]

{ #category : #accessing }
Terrain >> pheromones [

	^ pheromones
]

{ #category : #accessing }
Terrain >> proies [

	^ proies
]

{ #category : #accessing }
Terrain >> removeToDepot: aNumber [

	fourmiliere removeToDepot: aNumber
]

{ #category : #initialization }
Terrain >> startGraphicAnimation [

	| temp |
	temp := TerrainVue with: self.
	temp start.
	home := temp home.
	mainScreen := temp mainScreen.
	space := temp space.
]

{ #category : #adding }
Terrain >> versAdulte [

	nbNymphes := nbNymphes - 1.
	nbAdultes := nbAdultes + 1
]

{ #category : #adding }
Terrain >> versLarve [

	nbOeufs := nbOeufs - 1.
	nbLarves := nbLarves + 1
]

{ #category : #adding }
Terrain >> versNymphe [

	nbLarves := nbLarves - 1.
	nbNymphes := nbNymphes + 1
]
