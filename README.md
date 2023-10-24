# NIPS_data_to_phi
Text mining the NIPS dataset from the UCI Machine Learning repository. This project uses parallel computing in R to calculate contingency tables. Contingency tables are needed to calculate phi correlation matrices, for network analysis. 

The dataset can be found here: http://archive.ics.uci.edu/dataset/371/nips+conference+papers+1987+2015

The dataset summarizes the number of times a given word appears within an published paper from the NIPS (Neural Information Processing Systems) conference.

The original dataset was dichotomized such that a 1 = the word appeared, and 0 = the word did not appear. The overall project is only interested in whether a word appeared for a single article (see word_mat.csv). 

Files used to submit the project to the computer cluster are not published. 

