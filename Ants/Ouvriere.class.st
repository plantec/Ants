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
	#name : #Ouvriere,
	#superclass : #Role,
	#instVars : [
		'dateDeCreation',
		'tacheActuelle',
		'dateDebutTache',
		'estLeader',
		'maDernierePosition',
		'targetCarried',
		'monAvantDernierePosition',
		'monAvantAvantDernierePosition',
		'maNourriture'
	],
	#category : #Ants
}

{ #category : #action }
Ouvriere >> action: aNumber [

	"Je consome ma nourriture toutes les 1440 minutes (24h)"
	aNumber - dateDeCreation % 100 = 0 ifTrue: [ 
		maNourriture := maNourriture - (1 / 3)].
	
	"Si je n'ai plus de reserve de nourriture je meurs."
	maNourriture <= 0 ifTrue: [ monEntite dead.
		^self].

	"Si je ne suis pas entrain de porter une cible."
	targetCarried ifNil: [ self deplacementEnChasse: monEntite position.
		^ self ].

	"Si je suis entrain de porter une cible."
	self deplacementAvecProie: monEntite position 
]

{ #category : #action }
Ouvriere >> choixDeplacementAvecPheromone: aPoint [

	| pheromonesVisibles nouvelEmplacement x y |
	pheromonesVisibles := self pheromoneAutourDeMoiPourRetourFourmiliere.

	(pheromonesVisibles size = 0)
		ifTrue: [ 
			monAvantAvantDernierePosition := monAvantDernierePosition.
			monAvantDernierePosition := maDernierePosition.
			maDernierePosition := aPoint.
			monEntite position: { 
						(aPoint x @ (aPoint y - 3)).
						(aPoint x @ (aPoint y + 3)).
						(aPoint x - 3 @ aPoint y).
						(aPoint x + 3 @ aPoint y) } atRandom.
						^self ];
		ifFalse: [ 
			(pheromonesVisibles size > 2)
				ifTrue: [ 
					pheromonesVisibles do: [ :pheromone | 
							pheromone = maDernierePosition ifFalse: [ 
									estLeader := false.
									monAvantAvantDernierePosition := monAvantDernierePosition.
									monAvantDernierePosition := maDernierePosition.
									maDernierePosition := aPoint.
									pheromone dateDeCreation: monEntite terrain heure.
									monEntite position: pheromone position.
									^self] ] ];
				ifFalse: [ 
					nouvelEmplacement := pheromonesVisibles asArray atRandom.
					nouvelEmplacement dateDeCreation: monEntite terrain heure.
					nouvelEmplacement := 2 * aPoint x - nouvelEmplacement position x
					                     @
						                     (2 * aPoint y
						                      - nouvelEmplacement position y) ] ].

	x := nouvelEmplacement x.
	y := nouvelEmplacement y.
	monAvantAvantDernierePosition := monAvantDernierePosition.
	monAvantDernierePosition := maDernierePosition.
	maDernierePosition := aPoint.
	x < 5 | (x > 795) ifTrue: [ 
		y < 200 ifTrue: [ ^ aPoint x @ (aPoint y + 3) ].
		monEntite position: aPoint x @ (aPoint y - 3).
		^ self ].

	y < 5 | (y > 395) ifTrue: [ 
		x < 400 ifTrue: [ ^ aPoint x + 3 @ aPoint y ].
		monEntite position: aPoint x - 3 @ aPoint y.
		^ self ].

	monEntite position: x @ y
]

{ #category : #action }
Ouvriere >> deplacementAvecProie: aPoint [

	| pheromonesVisibles nouvelEmplacement |
	"Si je suis sur la fourmilière je dépose ma proie."
	(self entiteSurFourmiliere) ifTrue: [ 
		monEntite terrain addProieAuDepot: targetCarried.
		targetCarried := nil.
		estLeader := false.
		monAvantAvantDernierePosition := monAvantDernierePosition.
		monAvantDernierePosition := maDernierePosition.
		maDernierePosition := aPoint.
		monEntite position: aPoint.
		^self ].

	"Sinon je me déplace."
	pheromonesVisibles := self pheromoneAutourDeMoi.
	monAvantAvantDernierePosition := monAvantDernierePosition.
	monAvantDernierePosition := maDernierePosition.
	maDernierePosition := aPoint.

	"Si je ne vois pas de pheromone, je me déplace aléatoirement."
	pheromonesVisibles size = 0 ifTrue: [ 
		nouvelEmplacement := { 
			                     (aPoint x @ (aPoint y - 3)).
			                     (aPoint x @ (aPoint y + 3)).
			                     (aPoint x - 3 @ aPoint y).
			                     (aPoint x + 3 @ aPoint y) } atRandom.
		targetCarried position: nouvelEmplacement.
		monEntite position: nouvelEmplacement.
		^self].

	"Sinon je suis la piste de pheromone."
	nouvelEmplacement := pheromonesVisibles asArray atRandom.
	nouvelEmplacement dateDeCreation: monEntite terrain heure.
	nouvelEmplacement := nouvelEmplacement position.
	targetCarried position: nouvelEmplacement.
	monEntite position: nouvelEmplacement
]

{ #category : #action }
Ouvriere >> deplacementEnChasse: aPoint [

	| voisins |
	monAvantAvantDernierePosition ifNil: [ 
		monAvantAvantDernierePosition := aPoint ].
	monAvantDernierePosition ifNil: [ monAvantDernierePosition := aPoint ].
	maDernierePosition ifNil: [ maDernierePosition := aPoint ].

	" Si une proie est très proche"
	voisins := self proieProche.
	voisins do: [ :temp | 
		temp isAlive
			ifTrue: [ "J'attaque la proie."
				temp addAttacker: self.
				monEntite position: (temp position).
				^self ];
			ifFalse: [ 
				temp isCarried ifFalse: [ "Je ramène une proie morte à la fourmilière."
						temp isCarried: true.
						targetCarried := temp.
						maDernierePosition := aPoint.
						monAvantDernierePosition := aPoint.
						monAvantAvantDernierePosition := aPoint.
						monEntite position: maDernierePosition.
						^self ] ] ].

	" Sinon je me déplace en fonction de Leader ou pas "
	estLeader ifFalse: [ self mouvementEnChasseFollower: aPoint.
		^self ].
	self mouvementEnChasseLeader: aPoint
]

{ #category : #action }
Ouvriere >> entiteSurFourmiliere [

	| fourmiliere radius |
	
	fourmiliere := monEntite fourmiliere.
		
	"(x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)  racine carré"
	radius := (( monEntite position x - fourmiliere position x ) squared + ( monEntite position y - fourmiliere position y ) squared) sqrt.
	^ (radius < 10).
]

{ #category : #accessing }
Ouvriere >> estLeader [

	^ estLeader
]

{ #category : #initialization }
Ouvriere >> initializeOuvriere [

	dateDeCreation := monEntite terrain heure.
	maNourriture := 2.
	dateDebutTache := monEntite terrain heure.
	isAttacking := false.
	tacheActuelle := 'Chasse'.
	estLeader := false
]

{ #category : #action }
Ouvriere >> mouvementEnChasseFollower: aPoint [

	| pheromonesVisibles nouvelEmplacement |
	pheromonesVisibles := self pheromoneAutourDeMoi.
	monAvantAvantDernierePosition := monAvantDernierePosition.
	monAvantDernierePosition := maDernierePosition.
	maDernierePosition := aPoint.
	pheromonesVisibles size = 0 ifFalse: [ 
		nouvelEmplacement := pheromonesVisibles asArray atRandom.
		nouvelEmplacement dateDeCreation: monEntite terrain heure.
		monEntite position: nouvelEmplacement position.
		^ self ].
	estLeader := true.
	monEntite position: { 
			(aPoint x @ (aPoint y - 3)).
			(aPoint x @ (aPoint y + 3)).
			(aPoint x - 3 @ aPoint y).
			(aPoint x + 3 @ aPoint y) } atRandom
]

{ #category : #action }
Ouvriere >> mouvementEnChasseLeader: aPoint [

	| voisins x y |
	"Si une proie est relativement proche, je me r'approche d'elle."
	voisins := self proieVisible: aPoint.
	voisins do: [ :temp | 
		temp isCarried ifFalse: [ 
			aPoint x - temp position x < 0 ifTrue: [ x := aPoint x + 2 ]. "fourmis doit aller a droite"
			aPoint x - temp position x > 0 ifTrue: [ x := aPoint x - 2 ]. "fourmis doit aller a gauche"
			aPoint x - temp position x = 0 ifTrue: [ x := aPoint x ]. "fourmis ne bouge pas horizontalement"
			aPoint y - temp position y < 0 ifTrue: [ y := aPoint y + 2 ]. "fourmis doit aller en bas"
			aPoint y - temp position y > 0 ifTrue: [ y := aPoint y - 2 ]. "fourmis doit aller en haut"
			aPoint y - temp position y = 0 ifTrue: [ y := aPoint y ]. "fourmis ne bouge pas verticalement"
			monEntite position: x@y.
			monEntite addPheromone.
			^self ] ].

	"Sinon je me déplace par rapport aux pheromones qui m'entourent."
	self choixDeplacementAvecPheromone: aPoint.
	monEntite addPheromone.

	
]

{ #category : #action }
Ouvriere >> pheromoneAutourDeMoi [
	| liste radius |
	
	liste := OrderedCollection new.
	
	(monEntite terrain pheromones) do: 
	[	:temp |

		(temp position = monEntite position )
		ifFalse: 
		[ 	
			"(x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)  racine carré"
			radius := (( monEntite position x - temp position x ) squared + ( monEntite position y - temp position y ) squared) sqrt.
			(radius <= 3)
			ifTrue:
			[	
				((monEntite position  = temp position) | (maDernierePosition  = temp position) | (monAvantDernierePosition  = temp position) | (monAvantAvantDernierePosition  = temp position)) ifFalse: [ liste add: temp. ].		
			].
		].
	].
	
	^ liste.
]

{ #category : #action }
Ouvriere >> pheromoneAutourDeMoiPourRetourFourmiliere [

	| liste radius |
	
	liste := OrderedCollection new.
	
	(monEntite terrain pheromones) do: 
	[	:temp |
		
		(temp position = monEntite position )
		ifFalse: 
		[ 	
			"(x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)  racine carré"
			radius := (( monEntite position x - temp position x ) squared + ( monEntite position y - temp position y ) squared) sqrt.
			(radius < 4)
			ifTrue:
			[	
				(monEntite position = temp position) ifFalse: [ liste add: temp. ].
			].
		].
	].
	
	^ liste.
]
