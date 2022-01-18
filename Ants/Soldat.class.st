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
	#name : #Soldat,
	#superclass : #Role,
	#category : #Ants
}

{ #category : #action }
Soldat >> action: aNumber [

	| voisins nouvelEmplacement |
	voisins := self proieProche.
	voisins do: [ :temp | 
		temp isAlive ifTrue: [ 
			temp addAttacker: self.
			monEntite position: temp position ] ].

	nouvelEmplacement := self proieAutourDeFourmiliere.

	nouvelEmplacement ifNil: [ 
		nouvelEmplacement := self randomMouvement: (monEntite position) ].

	monEntite position: nouvelEmplacement 
]

{ #category : #action }
Soldat >> fourmiliereAutourDeMoi [

	| fourmiliere radius |
	
	fourmiliere := monEntite fourmiliere.
	"(x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)  racine carré"
	radius := (( monEntite position x - fourmiliere position x ) squared + ( monEntite position y - fourmiliere position y ) squared) sqrt.
	(radius < 200)
	ifTrue:
	[
			^ fourmiliere.
	].
	^ nil.
]

{ #category : #initialization }
Soldat >> initialize [

	isAttacking := false
]

{ #category : #action }
Soldat >> proieAutourDeFourmiliere [

	| fourmiliere voisins x y |
	
	"je recupère ma fourmilière"
	fourmiliere := monEntite terrain fourmiliere.
	
	"je regarde si des proie sont proche de la fourmilière"
	voisins := self proieVisible: fourmiliere position. 
	voisins do: 
	[ :temp |

		temp isAlive ifTrue:
		[	
			"si une proie est proche de la fourmilière je me rapproche d'elle."
		 	(monEntite position x - temp position x) < 0 ifTrue: [ x := monEntite position x + 2 ]. "fourmis doit aller a droite"
			(monEntite position x - temp position x) > 0 ifTrue: [ x := monEntite position x - 2 ]. "fourmis doit aller a gauche"
			(monEntite position x - temp position x) = 0 ifTrue: [ x := monEntite position x ]. "fourmis ne bouge pas horizontalement"
			(monEntite position y - temp position y) < 0 ifTrue: [ y := monEntite position y + 2 ]. "fourmis doit aller en bas"
			(monEntite position y - temp position y) > 0 ifTrue: [ y := monEntite position y - 2 ]. "fourmis doit aller en haut"
			(monEntite position y - temp position y) = 0 ifTrue: [ y := monEntite position y ]. "fourmis ne bouge pas verticalement"
			^ x@y.
		].
	].

	^ nil.
]

{ #category : #action }
Soldat >> randomMouvement: aPoint [

	| maFourmiliere haut bas gauche droite nouvelEmplacement |
	maFourmiliere := self fourmiliereAutourDeMoi.
	maFourmiliere ifNil: [ ^ aPoint ].

	haut := aPoint x @ (aPoint y - 2).
	bas := aPoint x @ (aPoint y + 2).
	gauche := aPoint x - 2 @ aPoint y.
	droite := aPoint x + 2 @ aPoint y.

	((maFourmiliere position x - haut x) squared
	 + (maFourmiliere position y - haut y) squared) sqrt < 100
	& (haut x >= 0) & (haut x < 800) & (haut y >= 0) & (haut y < 400) 
		ifFalse: [ haut := aPoint ].

	((maFourmiliere position x - bas x) squared
	 + (maFourmiliere position y - bas y) squared) sqrt < 100
	& (bas x >= 0) & (bas x < 800) & (bas y >= 0) & (bas y < 400) 
		ifFalse: [ bas := aPoint ].

	((maFourmiliere position x - gauche x) squared
	 + (maFourmiliere position y - gauche y) squared) sqrt < 100
	& (gauche x >= 0) & (gauche x < 800) & (gauche y >= 0)
	& (gauche y < 400) ifFalse: [ gauche := aPoint ].

	((maFourmiliere position x - droite x) squared
	 + (maFourmiliere position y - droite y) squared) sqrt < 100
	& (droite x >= 0) & (droite x < 800) & (droite y >= 0)
	& (droite y < 400) ifFalse: [ droite := aPoint ].


	nouvelEmplacement := { 
		                     haut.
		                     bas.
		                     gauche.
		                     droite } atRandom.

	^ nouvelEmplacement
]
