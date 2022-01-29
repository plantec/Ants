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
	#name : #Proie,
	#superclass : #Entite,
	#instVars : [
		'poids',
		'vie',
		'numberOfAttackers',
		'isAttacked',
		'isAlive',
		'isCarried',
		'attackers',
		'timer'
	],
	#category : #Ants
}

{ #category : #'instance creation' }
Proie class >> new: aTerrain [

	^ self new
		  terrain: aTerrain;
		  yourself
]

{ #category : #action }
Proie >> action: aNumber [

	| x y |
	
	isAlive ifFalse: [ ^ self ].
	
	"Si la proie n'a plus de vie elle devient un cadavre."
	vie < 1 ifTrue: [ 
		isAlive := false.
		isAttacked := false.
		attackers := nil.
		timer := 0.
		updateState := true.
		^ self ].

	"Si le timer d'attaque dépasse 200 alors la proie s'ennfuie."
	timer > 200 ifTrue: [ 
		terrain deleteProie: self.
		^ self ].

	"Si il y a au moins autant de fourmis que la moitié du poids de la proie alors elle perds un point de vie par tour."
	attackers size >= (poids / 2) ifTrue: [ vie := vie - 1 ].

	"Si la proie est attaquée par au moins une fourmis, elle ne bouge plus et le timer d'attaque augmente."
	attackers size > 0 ifTrue: [ 
		timer := timer + 1.
		isAttacked := true.
		^ self ].

	"Sinon il ne se passe rien pour la proie alors elle se déplace aléatoirement."
	x := 7 atRandom - 4.
	x := position x + x.
	x < 5 ifTrue: [ x := 5 ].
	x > 795 ifTrue: [ x := 795 ].
	y := 7 atRandom - 4.
	y := position y + y.
	y < 5 ifTrue: [ y := 5 ].
	y > 395 ifTrue: [ y := 395 ].
	position := x@y
]

{ #category : #adding }
Proie >> addAttacker: anOuvriere [
	
	"ajout d'une fourmis à la liste d'attaquant de la proie."
	(attackers includes: anOuvriere) ifFalse: [ attackers add: anOuvriere. ].
	updateState := true
]

{ #category : #initialization }
Proie >> initialize [ 
	
	super initialize .
	self position: 800 atRandom @ 400 atRandom.
	poids := 10 atRandom .
	vie := poids.
	isAlive := true.
	isAttacked := false.
	timer := 0.
	isCarried := false.
	updateState := false.
	attackers := OrderedCollection new.
]

{ #category : #accessing }
Proie >> isAlive [

	^ isAlive
]

{ #category : #accessing }
Proie >> isAttacked [

	^ isAttacked.
]

{ #category : #accessing }
Proie >> isCarried [

	^ isCarried.
]

{ #category : #accessing }
Proie >> isCarried: aBoolean [

	isCarried := aBoolean .
]

{ #category : #accessing }
Proie >> poids [

	^ poids
]

{ #category : #accessing }
Proie >> position [ 

	^ position
]

{ #category : #accessing }
Proie >> position: aPoint [

	position := aPoint
]
