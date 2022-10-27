---
layout: post
tags: nn_layers
mathjax: true
excerpt: hey there
title: "Deconvolutions"
published: false
---

Convolutions have enjoyed a discrete success in neural network architectures. 
Their cousins, deconvolutions, are also popular in tasks that require to have an input and an output of the same dimension,
e.g. image segmentation. They are a bit tricky to make sense of with the usual sliding filter approach used to describe convolutions. 
Let's define them in a different way and then interpret the result with a sliding window approach.

Given an "image" $x\in\mathbb{R}^{n\times m}$ and a filter $w\in\mathbb{R}^{t\times t}$ 
the convolution operator produces a new image $z\in\mathbb{R}^{fill}$ with 
\\[
  z_{i, j}= \sum_{l=1}^t\sum_{k=1}^t w_{lk}x_{i-1+l, j-1+k}.
\\]
The convolution operation is usually depicted as sliding the filter over the image and taking the weighted sum of 
the indices of the components of the image that are selected by the filter. The weights in the sum are given by the filter.
This operation can also be defined as a matrix-vector multiplication. To give an example let's take $n=m=3$, $t=2$. If we write $x$
explicitly we get
\\[
  \tilde{x} = 
  \begin{bmatrix}
    x_{1, 1} \\ x_{1, 2}\\ x_{1, 3} \\\  
    x_{2, 1} \\ x_{2, 2} \\ x_{2, 3} \\\  
    x_{3, 1} \\ x_{3, 2} \\ x_{3, 3}
  \end{bmatrix}
\\]
We are looking for a matrix $V$ such that $\tilde{z} = V\tilde{x}$, with the elements of $V$ being related to $w_{i,j}$ in some way.
To figure out the elements of this matrix we look at the values of $z_{ij}$.  

From the expression above @TODO number the equation we have 
\\[
  z_{11}=v_{1,1}x_{1,1} + v_{1,2}x_{1,2} + v_{1,4}x_{2,1} + v_{1,5}x_{2,2},
\\]
thus $v_{1, 3}=v_{1, 6}=v_{1, 7}=v_{1, 8}=v_{1, 9}=0$ and $v_{1, 1}=w_{1,1}$, $v_{1, 2}=w_{1,2}$, $v_{1, 4}=w_{2,1}$, $v_{1, 5}=w_{2,2}$. 
Now we observe that the weights in the weighted sum $z_{i, j}$ are the same for all $i, j$. 
This tells us that the other rows of $V$ have the same values as the first row of $V$, but they differ in position of the zeros. 
To find the zeros in the other columns of $V$ we notice that, given the way we are unrolling $z$ and $x$, the first $t$
(in this case $2$) rows of $V$ will see the index $i$ increasing by $1$ and $j=1$, the second $t$ rows of $V$ will have 
$i$ increasing by $1$ and $j=2$, and so on. So we can move from one row to the next increasing $i$ or increasing $j$ (only sometimes). 
Increasing $i$ by one we get a formula for $z_{i+1,1}$, which is very similar to the formula for $z_{i,1}$
with the only difference that the first index of each $x_{a,b}$ is increased by one. 
This means that when we increase $i$  we build a row of $V$ by shifting the previous row by one element to the right 
(and adding a $0$ on the left). When we cannot increase $i$ (in our case $i$ cannot be $4$), we have to increase $j$. 
To increase $j$ means that the first element of $\tilde{x}$ we consider in the sum is two positions below the first element 
of $\tilde{x}$ we consider when we had $j$ instead of $j+1$. This means that  we build a row of $V$ by shifting the previous
row by two element to the right (and adding two zeros on the left). All in all we end up with a matrix
\\[
  V=
  \begin{bmatrix}
    w_{1, 1} & w_{1, 2} & 0 & w_{2, 1} & w_{2, 1} & 0 & 0 & 0 & 0 \\\  
    0 & w_{1, 1} & w_{1, 2} & 0 & w_{2, 1} & w_{2, 1} & 0 & 0 & 0 \\\  
    0 & 0 & 0 & w_{1, 1} & w_{1, 2} & 0 & w_{2, 1} & w_{2, 1} & 0 \\\  
    0 & 0 & 0 & 0 & w_{1, 1} & w_{1, 2} & 0 & w_{2, 1} & w_{2, 1}  
  \end{bmatrix}.
\\]
Now that we have this representation the operation of deconvolution is very easy to define. Basically instead of going 
from $\tilde{x}$ to $\tilde{z}$ we do the opposite. So instead of $V$ we use (not true we use the antitranspose ;P) $V^T$ and define 
\\[
  \tilde{x} = V^T \tilde{z}.
\\]
To rebuild the sliding window view just imagine padding $z$ with zeros on all sides and sliding the original filter on this padded version of $z$.
