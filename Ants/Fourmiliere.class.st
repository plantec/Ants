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
	#name : #Fourmiliere,
	#superclass : #Entite,
	#instVars : [
		'depot'
	],
	#category : #'Ants-Model'
}

{ #category : #'instance creation' }
Fourmiliere class >> new: aTerrain [

	^ self new
		  terrain: aTerrain;
		  yourself
]

{ #category : #action }
Fourmiliere >> action: aNumber [

	(aNumber % 10 == 0)
	ifTrue: 
		[
			terrain addFourmis.
		].
]

{ #category : #accessing }
Fourmiliere >> addToDepot: aProie [

	depot := depot + aProie poids.
]

{ #category : #accessing }
Fourmiliere >> depot [ 

	^ depot
]

{ #category : #initialization }
Fourmiliere >> initialize [ 

	super initialize .
	depot := 200.
	updateState := false.
	self position: (600 atRandom + 100) @ (200 atRandom + 100).
]

{ #category : #accessing }
Fourmiliere >> position [ 
	
	^ super position.
]

{ #category : #accessing }
Fourmiliere >> position: aPoint [

	super position: aPoint.
]

{ #category : #accessing }
Fourmiliere >> removeToDepot: aNumber [

	depot := depot - aNumber
]
