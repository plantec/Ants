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
	myEntite:		<Object>


    Implementation Points
...
"
Class {
	#name : #EntiteVue,
	#superclass : #BlElement,
	#instVars : [
		'myEntite',
		'isFourmis',
		'isProie'
	],
	#category : #'Ants-View'
}

{ #category : #'instance creation' }
EntiteVue class >> with: anObject as: aNumber [

	^ self new
		myEntite: anObject;
		initializeElementsAndAppareance: aNumber;
		yourself
]

{ #category : #action }
EntiteVue >> animation [

	self relocate: myEntite position.
	myEntite updateState ifTrue: [ self updateElementsAndAppareance. ]
	
]

{ #category : #initialization }
EntiteVue >> initializeElementsAndAppareance: aNumber [
	"0 : fourmiliere"
	"1 : proie"
	"2 : pheromone"
	"3 : fourmis"
	isFourmis := false.
	isProie := false.
	self geometry: BlCircleGeometry new.
	
	aNumber = 1 ifTrue: [ 
		isProie := true.
		self background: Color red.
		self size: myEntite poids @ myEntite poids ].
	
	aNumber = 3 ifTrue: [
		isFourmis := true.
		self background: Color white.
		self size: 4 @ 4 ].
	
	aNumber = 2 ifTrue: [ 
		self background: Color green.
		self size: 1 @ 1 ].
	
	self relocate: myEntite position.
	aNumber = 0 ifFalse: [ ^ self ].
	
	self background: Color blue.
	self size: 20 @ 20
]

{ #category : #accessing }
EntiteVue >> myEntite [

	^ myEntite
]

{ #category : #accessing }
EntiteVue >> myEntite: anObject [

	myEntite := anObject
]

{ #category : #initialization }
EntiteVue >> updateElementsAndAppareance [
	
	myEntite updateState: false.
	
	"Mise à jour de la couleur si l'entite est une proie."
	isProie ifTrue: [ 
		myEntite isAlive ifFalse: [ 
			self background: Color darkGray.
			^ self ].
		myEntite isAttacked ifTrue: [ 
			self background: Color purple.
			^ self ].
		self background: Color red.
		^ self ].

	"Mise à jour de la couleur si il s'agit d'une fourmis adulte."
	isFourmis ifFalse: [ ^ self ].
	myEntite monStade isAdulte ifFalse: [ ^ self ].
	myEntite isOuvriere ifTrue: [ 
		self background: Color orange.
		^ self ].
	myEntite isSoldat ifTrue: [ 
		self background: Color brown.
		^ self ].
	self background: Color pink
]
