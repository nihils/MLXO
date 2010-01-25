package ml.neural;

import ml.Pattern;

class Hopfield implements INeural
{
	private var numNeurons:Int;
	private var acts:Array<Float>;
	private var weights:Array<Array<Float>>;

	public function new(n:Int, c:Int) {
		numNeurons = n;
		acts = new Array<Float>();
		weights = new Array<Array<Float>>();
		for (i in 0...numNeurons){
			weights[i] = new Array<Float>();
			for (j in 0...numNeurons){
				weights[i][j] = 0.0;
			}
		}
	}
	public function train(patterns:Array<Pattern>, ?iterations:Int):Void {
		if (iterations == null) iterations = 1000; 
		for (i in 0...iterations){
			for (p in patterns){
				switch (p){
					case associate(memorize):
						update(memorize);
					default:
						trace("Hopfield network only supports auto-associative memory (for now), another type of pattern was supplied");
				}
			}
		}
	}
	public function test(patterns:Array<Pattern>):Void {
		for (p in patterns){
			switch (p){
				case associate(memorize):
					var predicted:Array<Float> = activate(memorize);
					trace(memorize.toString() + "->" + predicted.toString());
				default:
					trace("Hopfield network only supports auto-associative memory (for now), another type of pattern was supplied");
			}
		}
	}
	public function activate(inputs:Array<Float>):Array<Float> {	
		//Activation = signum(sum(weights where inputs == 1.0))
		for (j in 0...numNeurons){
			var sum:Float = 0.0;
			for (i in 0...numNeurons){
				if (inputs[i] == 1.0) sum += weights[j][i];
			}
			acts[j] = signum(sum);
		}
		return acts;
	}
	public function update(targets:Array<Float>):Void {
		if (targets.length != numNeurons) trace("Invalid Number of targets");
		var polarTargets:Array<Float> = new Array<Float>();
		//Convert binary neurons to bipolar neurons
		for (i in 0...numNeurons) (targets[i] == 0.0) ? polarTargets[i] = -1.0 : polarTargets[i] = 1.0; 
		//Change in weights = each neuron activation * each neuron activation
		var deltas:Array<Array<Float>> = new Array<Array<Float>>();
		for (i in 0...numNeurons) deltas[i] = new Array<Float>();	
		for (j in 0...numNeurons){
			for (i in 0...numNeurons){
				deltas[j][i] = polarTargets[i] * polarTargets[j];
			}
		}
		//A neuron doesn't connect to itself
		for (i in 0...numNeurons) deltas[i][i] = 0.0;
		//Incorporate change in weights to weights
		for (j in 0...numNeurons){
			for (i in 0...numNeurons){
				weights[j][i] += deltas[j][i];
			}
		}
	}
	inline static function signum(x:Float):Float {
		return (x >= 0.0) ? 1.0 : 0.0;
	}
}
