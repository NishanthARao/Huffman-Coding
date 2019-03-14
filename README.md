# Huffman-Coding
This is an attempt to calculate the huffman codes for a given source and its respective probabilities of source elements, under the constraint that it should have minimum variance implemented on MATLAB 2018a.

1)Run the file.

2)Provide the probabilities in descending order as an array. Eg.
If S = {s1, s2, s3, s4, s5, s6, s7} with probabilities p = {p1, p2, p3, p4, p5, p6, p7} then give the input as follows:
  [p1 p2 p3 p4 p5 p6 p7]
  
3)The output will be shown in a reader-friendly manner with the variance, entropy and efficiency of the code.

Note: 
1)This code works only for binary symbols.

2)The probabilities are assumed to be in descending order.
If the probabilities are not in descending order, then you have to interpret the result properly.
