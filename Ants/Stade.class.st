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
	#name : #Stade,
	#superclass : #Object,
	#instVars : [
		'heureNaissance',
		'monEntite',
		'isAdulte'
	],
	#category : #'Ants-Model'
}

{ #category : #testing }
Stade class >> isAbstract [
		
	^ self == Stade
]

{ #category : #action }
Stade >> action: aNumber [
]

{ #category : #action }
Stade >> evolution: aNumber [
]

{ #category : #accessing }
Stade >> heureNaissance [

	^ heureNaissance.
]

{ #category : #accessing }
Stade >> heureNaissance: aNumber [

	heureNaissance := aNumber.
]

{ #category : #accessing }
Stade >> isAdulte [

	^ isAdulte
]

{ #category : #accessing }
Stade >> isAdulte: anObject [

	isAdulte := anObject
]

{ #category : #accessing }
Stade >> monEntite [

	^ monEntite
]

{ #category : #accessing }
Stade >> monEntite: anObject [

	monEntite := anObject
]

{ #category : #action }
Stade >> mouvement: aPoint [
]
