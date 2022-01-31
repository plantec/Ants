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
	#name : #Adulte,
	#superclass : #Stade,
	#instVars : [
		'role'
	],
	#category : #'Ants-Model'
}

{ #category : #accessing }
Adulte class >> at: aNumber with: aFourmis [

	^ self new
		heureNaissance: aNumber;
		monEntite: aFourmis;
		isAdulte: true;
		roleInitialize;
		yourself
]

{ #category : #action }
Adulte >> action: aNumber [
	
	^ role action: aNumber.
]

{ #category : #accessing }
Adulte >> role [

	^ role
]

{ #category : #initialize }
Adulte >> roleInitialize [

	| temp |
	temp := 100 atRandom.
	"Reine"
	temp = 1 ifTrue: [ 
		role := Reine new.
		role monEntite: monEntite.
		monEntite isReine: true.
		^ self ].
	"Soldat"
	temp < 21 ifTrue: [ 
		role := Soldat new.
		role monEntite: monEntite.
		monEntite isSoldat: true.
		^ self ].
	"Ouvriere"
	role := Ouvriere new.
	role monEntite: monEntite.
	monEntite isOuvriere: true.
	role initializeOuvriere
]
