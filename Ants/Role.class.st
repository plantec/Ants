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
	#name : #Role,
	#superclass : #Object,
	#instVars : [
		'monEntite',
		'isAttacking'
	],
	#category : #Ants
}

{ #category : #testing }
Role class >> isAbstract [
		
	^ self == Role
]

{ #category : #action }
Role >> action: aPoint [
]

{ #category : #accessing }
Role >> monEntite [

	^ monEntite
]

{ #category : #accessing }
Role >> monEntite: anObject [

	monEntite := anObject
]

{ #category : #accessing }
Role >> proieProche [

	| liste radius |
	
	liste := OrderedCollection new.
	
	(monEntite terrain proies) do: 
	[	:temp |
		
		"(x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)  racine carré"
		radius := (( monEntite position x - temp position x ) squared + ( monEntite position y - temp position y ) squared) sqrt.
		(radius < 4)
		ifTrue:
		[
			liste add: temp.
		].
	].
	
	^ liste.
]

{ #category : #'as yet unclassified' }
Role >> proieVisible: aPoint [

	| liste radius |
	
	liste := OrderedCollection new.
	
	(monEntite terrain proies) do: 
	[	:temp |
		
		"(x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)  racine carré"
		radius := (( aPoint x - temp position x ) squared + ( aPoint y - temp position y ) squared) sqrt.
		(radius < 100)
		ifTrue:
		[
			liste add: temp.
		].
	].
	
	^ liste.
]
