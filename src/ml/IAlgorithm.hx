package ml;

interface IAlgorithm
{
	function train(patterns:Array<Pattern>, ?iterations:Int):Void;
	function test(patterns:Array<Pattern>):Void;
}
