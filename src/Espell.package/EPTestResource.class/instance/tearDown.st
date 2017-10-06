running
tearDown

	objectSpace := nil.
	imagesDirectory exists ifTrue: [ imagesDirectory deleteAll ].
	'PharoV30.sources' asFileReference ensureDelete