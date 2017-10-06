compiling
isClassDefinitionSelector: aSelector
	
	^ #(
	subclass:type:uses:instanceVariableNames:classVariableNames:classInstanceVariableNames:poolDictionaries:compactClassIndex:category:
	variableByteSubclass:instanceVariableNames:classVariableNames:
	subclass:instanceVariableNames:classVariableNames:
	variableSubclass:instanceVariableNames:classVariableNames:
	variableWordSubclass:instanceVariableNames:classVariableNames:
	weakSubclass:instanceVariableNames:classVariableNames:) includes: aSelector