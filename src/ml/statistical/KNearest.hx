/*
Created by Nihil Shah
Last Edited: 9/28/2009
*/

package ml.statistical;

import ml.Pattern; 
import ml.IAlgorithm;

class KNearest implements IAlgorithm
{
	public function new(nf:Int, k:Int, ?c:Array<String>) {
		numFeatures = nf;
		if (c != null) classes = c;
	}
	public function train(patterns:Array<Pattern>, ?iterations:Int):Void {
		for (p in patterns){
                    switch (p){
                        case classifer(features, type):
                            
                        case regression(inputs, outputs):

                    }
		}
	}
	public function test(patterns:Array<Pattern>):Void {

	}
}
