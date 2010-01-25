package ml.neural;

import ml.IAlgorithm;

interface INeural implements IAlgorithm
{
	//Activate Neurons
	function activate(inputs:Array<Float>):Array<Float>;
	//Update Weights
	function update(targets:Array<Float>):Void;
}
