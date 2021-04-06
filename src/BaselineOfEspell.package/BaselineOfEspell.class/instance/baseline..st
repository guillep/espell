baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ 
			spec description: 'Espell Object Spaces'.			
			spec configuration: 'ASTInterpreter' with: [
				spec
					className: #ConfigurationOfASTInterpreter;
					versionString: '0.7.5';
					loads: #('default');
					repository: 'http://smalltalkhub.com/mc/Pharo/AST-Interpreter/main' ].

			"Needs VM simulator"
			spec
				baseline: 'Spur'
				with: [ 
					spec repository: 'github://pharo-project/opensmalltalk-vm' ].

			spec package: 'EspellSimulator' with: [ spec requires: #( 'Espell' 'Spur' ) ].
			spec package: 'Espell' with: [ spec requires: #( 'ASTInterpreter' ) ]. ]