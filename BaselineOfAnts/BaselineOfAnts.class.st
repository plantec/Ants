Class {
	#name : #BaselineOfAnts,
	#superclass : #BaselineOf,
	#category : #BaselineOfAnts
}

{ #category : #baselines }
BaselineOfAnts >> baseline: spec [
	<baseline>

	spec for: #common do: [
		
		"Load Bloc"
		spec baseline: 'NewBloc' with: [ spec repository: 'github://pharo-graphics/Bloc/src' ].
		
		spec package: 'Ants'.
	]

]
