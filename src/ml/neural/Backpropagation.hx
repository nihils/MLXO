package ml.neural; 

import ml.Pattern;

class Backpropagation implements INeural 
{
	private var normalized:Bool;
	private var numInputs:Int;
	private var numHidden:Int;
	private var numOutputs:Int;
	private var actInputs:Array<Float>;
	private var actHidden:Array<Float>;
	private var actOutputs:Array<Float>;
	private var weightInputs:Array<Array<Float>>;
	private var weightOutputs:Array<Array<Float>>;
	private var maxOutput:Float;
	private var minOutput:Float;

	public function new(ni:Int, nh:Int, no:Int) {
		numInputs = ni;  
		numHidden = nh;
		numOutputs = no;
		//Init activation arrays
		actInputs = new Array<Float>();
		actHidden = new Array<Float>();
		actOutputs = new Array<Float>(); 	
		//Generate random input->hidden weights 
		weightInputs = new Array<Array<Float>>();
		for (i in 0...numInputs){
			weightInputs[i] = new Array<Float>();
			for (j in 0...numHidden){
				weightInputs[i][j] =  1.8 * Math.random() + 0.2;
			}
		}
		//Generate random hidden->output weights
		weightOutputs = new Array<Array<Float>>();
		for (i in 0...numHidden){
			weightOutputs[i] = new Array<Float>();
			for (j in 0...numOutputs){
				weightOutputs[i][j] =  1.8 * Math.random() + 0.2;
			}
		}
	}
	public function train(patterns:Array<Pattern>, ?iterations:Int):Void {
		if (iterations == null) iterations = 1000;
		for (i in 0...iterations){
			for (p in patterns){
				switch (p){
					case regression(inputs, outputs):
						activate(inputs);
						update(outputs);
					default:
						trace("Backpropagation Network only supports regression, another type of pattern was supplied");
				}
			}
		}
	}
	public function test(patterns:Array<Pattern>):Void {
		for (p in patterns){
			switch (p){
				case regression(inputs, outputs):
					var predicted:Array<Float> = activate(inputs);
					trace(inputs.toString() + " -> " + predicted.toString() + " -> " + outputs.toString());   
				default:
					trace("Backpropagation Network only supports regression, another type of pattern was supplied");
			}
		}		
	}
	public function activate(inputs:Array<Float>):Array<Float> {
		//Input neuron activations =  The input values
		for (i in 0...numInputs){
			actInputs[i] = inputs[i];
		}	
		//Hidden neuron activations = sigmoid(sum(input neuron activations * random/adjusted weights))
		for (j in 0...numHidden){
			var sum:Float = 0.0;
			for (i in 0...numInputs){
				sum += actInputs[i] * weightInputs[i][j];
			}
			actHidden[j] = sigmoid(sum);
		}
		//Output neuron activations = sigmoid(sum(hidden neuron activations * random/adjusted weights)) = Expected output values
		for (j in 0...numOutputs){
			var sum:Float = 0.0;
			for (i in 0...numHidden){
				sum += actHidden[i] * weightOutputs[i][j];
			}
			actOutputs[j] = sigmoid(sum);
		}
		return actOutputs;
	}
	public function update(targets:Array<Float>):Void { 
		if (targets.length != numOutputs) trace("Invalid number of targets");
 		var thetaOutputs:Array<Float> = new Array<Float>(); 	
		//Change in output thetas = dsigmoid(z) * (y - z) * lambda. Lambda = 0.2 for output neurons, z = predicted output, y = actual output
		for (i in 0...numOutputs){
			thetaOutputs[i] = dsigmoid(actOutputs[i]) * (targets[i] - actOutputs[i]) * 0.2; 
		}
		//Change in hidden thetas = sum(change in output thetas * old hidden->output weights) * dsigmoid(z) * lambda. Lambda = 0.15 for hidden neurons, z = hidden neuron output.   
		var thetaHidden:Array<Float> = new Array<Float>();
		for (i in 0...numHidden){
			var error:Float = 0.0;
			for (j in 0...numOutputs){
				error += thetaOutputs[j] * weightOutputs[i][j];
			}	
			thetaHidden[i] = dsigmoid(actHidden[i]) * error * 0.15;
		}
		//Update input->hidden weights. Change in weight = change in hidden theta * input activations
		for (j in 0...numHidden){
			for (i in 0...numInputs){
				weightInputs[i][j] += thetaHidden[j] * actInputs[i];
			}
		}
		//Update hidden->output weights. Change in weight = change in output theta * hidden activations
		for (j in 0...numOutputs){
			for (i in 0...numHidden){
				weightOutputs[i][j] += thetaOutputs[j] * actHidden[i];
			}
		}
	} 
	inline private function sigmoid(x:Float):Float {
		//This is our chosen sigmoid function = tanh(x) = exp(2x) - 1 / exp(2x) + 1, better than the standard 1 / 1 + exp(-x)
		return (Math.exp(2 * x) - 1) / (Math.exp(2 * x) + 1);
	}
	inline private function dsigmoid(z:Float):Float {
		//This function is used to calculate the change in weights based on the error, this is the derivative of the sigmoid function above in terms of the output of the sigmoid function. 
		return 1.0 - (z * z); 
	}
}
