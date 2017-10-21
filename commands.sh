#!/bin/sh
#Data partioning 80-20%
java -Xmx5g weka.filters.supervised.instance.StratifiedRemoveFolds -i input_file.arff -o output_file_train80.arff -c last -S 5 -N 5 -F 1 -V
java -Xmx5g weka.filters.supervised.instance.StratifiedRemoveFolds -i input_file.arff -o output_file_test20.arff -c last -S 5 -N 5 -F 1

#NonSparse To Sparse
java -Xmx10g weka.filters.unsupervised.instance.NonSparseToSparse -i output_file_train80.arff -o output_file_train80_sparse.arff
java -Xmx10g weka.filters.unsupervised.instance.NonSparseToSparse -i output_file_test20.arff -o output_file_test20_sparse.arff

#Training and Testing, Default 10-fold cross-validation for training
java -Xmx10g weka.classifiers.meta.FilteredClassifier -F "weka.filters.unsupervised.attribute.Remove -R first" -W weka.classifiers.bayes.NaiveBayes -t output_file_train80_sparse.arff -o -i -d output_file_NaiveBayes.model>output_file_train80_NaiveBayes.result
java -Xmx10g weka.classifiers.bayes.NaiveBayes -T output_file_test20_sparse.arff -l output_file_NaiveBayes.model -no-cv -o -i >output_file_test20_NaiveBayes.result
java -Xmx10g weka.classifiers.bayes.NaiveBayes -T output_file_train80_sparse.arff -l output_file_NaiveBayes.model -no-cv -p 1 -distribution >output_file_train80_NaiveBayes_sparse.p
java -Xmx10g weka.classifiers.bayes.NaiveBayes -T output_file_test20_sparse.arff -l output_file_NaiveBayes.model -no-cv -p 1 -distribution >output_file_test20_NaiveBayes_sparse.p