"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestFourmiliere,
	#superclass : #PackageManifest,
	#category : #Ants
}

{ #category : #'code-critics' }
ManifestFourmiliere class >> ruleToDoWithIncrementRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#Fourmiliere)) #'2022-01-17T10:57:06.982+01:00') )
]
