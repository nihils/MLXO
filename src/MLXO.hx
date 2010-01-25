/*
Created by Nihil Shah
Last Edited: 9/27/2009
*/

package ;

import ml.Pattern;
import ml.statistical.NaiveBayes;
import ml.statistical.Kernel;

class MLXO 
{
	public function new() {
		//The three classes
		var cls:Array<String> = [
			"Apple",
			"Orange",
			"Pear",
		];
		//Create the NaiveBayes classifier with 3 features, an normal distribution for each feature, and with the above classes
		var bayes:NaiveBayes = new NaiveBayes(3, NBNormal, cls); 			
		//Train the classifier with three examples in each categorey
		var pat:Array<Pattern> = [
			classifer([1.0, 5.0, 0.0], "Apple"),
			classifer([1.2, 4.7, 0.0], "Apple"),
			classifer([1.2, 5.5, 0.1], "Apple"),
			classifer([2.0, 3.0, 1.0], "Orange"),
			classifer([1.9, 3.2, 1.4], "Orange"),
			classifer([2.2, 2.9, 0.9], "Orange"),
			classifer([3.0, 9.0, 3.0], "Pear"),
			classifer([2.6, 8.8, 2.8], "Pear"),
			classifer([3.4, 9.3, 3.1], "Pear"),
		];
		bayes.train(pat);
		//Test the classifier with two examples in each categorey
		var pat2:Array<Pattern> = [
			classifer([1.3, 5.2, 0.4], "Apple"),
			classifer([1.1, 5.9, 0.2], "Apple"),
			classifer([2.5, 3.2, 1.0], "Orange"),
			classifer([1.8, 2.8, 1.2], "Orange"),
			classifer([3.3, 8.7, 3.2], "Pear"),
			classifer([2.8, 9.5, 3.5], "Pear"),
		];
		bayes.test(pat2);
	}
	static public function main():Void {
		var m:MLXO = new MLXO();
	}
}
