/*
Created by Nihil Shah
Last Edited: 10/3/2009 
*/

package ml.statistical;

import ml.Pattern;
import ml.IAlgorithm;

class NaiveBayes implements IAlgorithm
{
        private var numFeatures:Int;
        private var classes:Array<String>;
        private var priors:Hash<Float>;
        private var params1:Hash<Array<Float>>;
        private var params2:Hash<Array<Float>>;
        private var kernel:Kernel;

        public function new(nf:Int, kern:Kernel, ?c:Array<String>) {
                numFeatures = nf;
                if (c != null) classes = c;
                kernel = kern;
                params1 = new Hash<Array<Float>>();
                params2 = new Hash<Array<Float>>();
                priors = new Hash<Float>();
        }
        public function train(patterns:Array<Pattern>, ?iterations:Int):Void {
                for (c in classes){
                        //Find all patterns in a class
                        var a = function(p:Pattern):Bool {
                                switch (p){
                                        case classifer(features, type):
                                                return type == c;
                                        default:
                                                return false;
                                }
                        }
                        //Set prior probability of class p(c)
                        //p(c) = number of patterns in class / number of patterns
                        var cPatterns:List<Pattern> = Lambda.filter(patterns, a);
                        priors.set(c, (cPatterns.length / patterns.length));
                        //Create likelihood probability distribution for each feature p(f1...fn | c)
                        switch (kernel){
                                //For a Normal Probability Distribution, the mean and standard deviation for each feature is calculated
                                case NBNormal:
                                        var sum1:Array<Float> = new Array<Float>();
                                        var sum2:Array<Float> = new Array<Float>();
                                        var mean:Array<Float> = new Array<Float>();
                                        var stdev:Array<Float> = new Array<Float>();
                                        for (i in 0...numFeatures){
                                                //Calculate Mean
                                                sum1[i] = sum2[i] = mean[i] = stdev[i] = 0.0;
                                                var b = function(p:Pattern):Void {
                                                        switch (p){
                                                                case classifer(features, type):
                                                                        sum1[i] += features[i]; 
                                                                default:
                                                                        trace("");
                                                        }
                                                }
                                                Lambda.iter(cPatterns, b);
                                                mean[i] = sum1[i] / cPatterns.length; 
                                                //Calculate Standard Deviation
                                                var d = function(p:Pattern):Void {
                                                        switch (p){
                                                                case classifer(features, type):
                                                                        sum2[i] += (features[i] - mean[i]) * (features[i] - mean[i]);
                                                                default:
                                                                        trace("");
                                                        }
                                                }
                                                Lambda.iter(cPatterns, d);
                                                stdev[i] = Math.sqrt(sum2[i] / cPatterns.length);
                                        }               
                                        params1.set(c, mean);
                                        params2.set(c, stdev);
                                default:
                                        trace("");
                        }
                }
        }
        public function test(patterns:Array<Pattern>):Void {
                for (p in patterns){
                        switch (p){
                                case classifer(features, type):
                                        for (c in classes){
                                                //Find likelihood probability p(f1...fn | c)
                                                //p(f1...fn | c) = p(f1 | c) * p(f2 | c) * ... * p(fn | c) 
                                                var likelihood:Float = 1.0;
                                                switch (kernel){
                                                        case NBNormal: for (i in 0...numFeatures) likelihood *= normalcdf(params1.get(c)[i], params2.get(c)[i], features[i]); 
                                                        default: trace("");
                                                }
                                                //Bayes' theorem: p(c | f1...fn) = p(c)p(f1...fn | c) / p(f1...fn)
                                                //p(f1...fn) is always 1 
                                                var posterior:Float = priors.get(c) * likelihood;
                                                trace(posterior + " of being " + type + " and is really " + c);  
                                        }
                                default:
                                        trace("");
                        }       
                }
        }
        inline private function normalcdf(mu:Float, sigma:Float, x:Float):Float {
                var z:Float = (x - mu) / sigma;
                return z;
        }
}
