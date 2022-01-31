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
	#name : #Fourmis,
	#superclass : #Entite,
	#instVars : [
		'monStade',
		'fourmiliere',
		'isOuvriere',
		'isSoldat',
		'isReine'
	],
	#category : #'Ants-Model'
}

{ #category : #accessing }
Fourmis class >> in: aTerrain at: aFourmiliere hour: aNumber [

	^ self new
		terrain: aTerrain;
		fourmiliere: aFourmiliere;
		position: aFourmiliere position;
		initializeStade;
		yourself.
]

{ #category : #action }
Fourmis >> action: aNumber [

	monStade action: aNumber.
	
	

	
]

{ #category : #action }
Fourmis >> addPheromone [

	terrain addPheromone: self.
	
	

	
]

{ #category : #action }
Fourmis >> dead [ 
	
	terrain deleteEntite: self.
	
	

	
]

{ #category : #action }
Fourmis >> evolutionVersAdulte: aNumber [

	terrain versAdulte.
	monStade := Adulte at: aNumber with: self.
	updateState := true

	
]

{ #category : #action }
Fourmis >> evolutionVersLarve: aNumber [

	terrain versLarve.
	monStade := (Larve at: aNumber with: self)
]

{ #category : #action }
Fourmis >> evolutionVersNymphe: aNumber [
	
	terrain versNymphe.
	fourmiliere removeToDepot: 2.
	monStade := Nymphe at: aNumber with: self


	
]

{ #category : #accessing }
Fourmis >> fourmiliere [

	^ fourmiliere
]

{ #category : #accessing }
Fourmis >> fourmiliere: aFourmiliere [

	fourmiliere := aFourmiliere
]

{ #category : #initialization }
Fourmis >> initialize [ 
	
	super initialize.
	isOuvriere := false.
	isSoldat := false.
	isReine := false.
	updateState := false.
	self position: 800 atRandom @ 400 atRandom.
]

{ #category : #accessing }
Fourmis >> initializeStade [

monStade := (Oeuf at: (terrain heure) with: self).
]

{ #category : #accessing }
Fourmis >> isOuvriere [

	^ isOuvriere
]

{ #category : #accessing }
Fourmis >> isOuvriere: anObject [

	isOuvriere := anObject
]

{ #category : #accessing }
Fourmis >> isReine [

	^ isReine
]

{ #category : #accessing }
Fourmis >> isReine: anObject [

	isReine := anObject
]

{ #category : #accessing }
Fourmis >> isSoldat [

	^ isSoldat
]

{ #category : #accessing }
Fourmis >> isSoldat: anObject [

	isSoldat := anObject
]

{ #category : #accessing }
Fourmis >> monStade [

	^ monStade
]

{ #category : #accessing }
Fourmis >> monStade: aStade [

	monStade:= aStade.
]

{ #category : #accessing }
Fourmis >> position [ 
	
	^ super position.
]

{ #category : #accessing }
Fourmis >> position: aPoint [

	super position: aPoint.
]
