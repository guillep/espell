initialize-release
interpreter: anEvaluator
	evaluator := anEvaluator.
	evaluator objectSpace: self.
	backend interpreter: anEvaluator