package ml.statistical;

import ml.Pattern; 
import ml.IAlgorithm;

class KNearest implements IAlgorithm
{
        private var numFeatures:Int;

	public function new(nf:Int, k:Int, ?c:Array<String>) {
		numFeatures = nf;
		if (c != null) classes = c;
	}
	public function train(patterns:Array<Pattern>, ?iterations:Int):Void {
                var distances:Array<Array<Float>> = new Array<Array<Float>>();
		for (p1 in patterns){
                    var p_distance_to:Array<Float> = new Array<Float>();
                    switch (p1){
                        case classifer(features1, type1):
                            for (p2_i in 0...patterns.length){
                                switch (patterns[p2_i]){
                                    case classifer(features2, type2):
                                        var distance:Float = 0.0;
                                        for (f in 0...numFeatures){
                                            distance += (features1[f] - features2[f]) * (features1[f] - features2[f]); 
                                        }
                                        p_distance_to.append(Math.sqrt(distance))
                                }
                            }
                        case regression(inputs1, outputs1):
                            for (p2_i in 0...patterns.length){
                                switch (patterns[p2_i]){
                                    case regression(inputs2, outputs2):
                                        var distance:Float = 0.0;
                                        for (f in 0...numFeatures){
                                            distance += (inputs1[f] - inputs2[f]) * (inputs1[f] - inputs2[f]); 
                                        }
                                        p_distance_to.append(Math.sqrt(distance))
                                }
                            }
                    }
                    distances.append(p_distance_to);
		}
	}
	public function test(patterns:Array<Pattern>):Void {

	}
}
