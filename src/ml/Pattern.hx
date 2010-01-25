package ml;

enum Pattern
{
	classifer(features:Array<Float>, type:String);
	regression(inputs:Array<Float>, outputs:Array<Float>);
	associate(memorize:Array<Float>);
}
