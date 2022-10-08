---
layout: post
tags: market_making
mathjax: true
excerpt: hey there
title: "Glosten Milgrom with imperfectly informed traders"
---

We extend the GM model presented [here]({{ site.baseurl }}{% link _posts/2022-08-11-glosten-milgrom-model.md %})
 to allow for informed traders to have imperfect information. 
By imperfect information we mean that the informed trader will follow a signal, say $\alpha$, to buy or sell. 
Differently from the base GM model, this signal is accurate with probability $\rho\in(\frac{1}{2}, 1]$.  
The case $\rho=1$ gives a perfectly informed trader (and we will see that the math gives the same result); 
while for $\rho$ close to $\frac{1}{2}$ the informed trader behaves like an uninformed trader. 
The signal can be to buy or sell, but we are going to use it in combination with the value of the asset, so we actually 
care about the signal being correct or not (independently of the direction). 
We denote these events by $\\{\alpha=C\\},\ \\{\alpha=W\\}$.  
We use the same notation and assumptions as in the previous post and move on to compute the bid-ask spreads to see how 
this additional assumption impacts it. We also  denote the events $\{V=V^H\}$and $\{V=V^L\}$ by just $V^H$ and $V^L$ 
respectively to make the notation more agile.
  
For the ask price we have 
\\[
    \begin{aligned}
        a_n &=\mathbb{E}\left[V\vert\Omega_{n-1}, d_n=1\right] = V^H \mathbb{P}\left(V^H\vert\Omega_{n-1}, d_n=1\right) +  V^L \mathbb{P}\left(V^L\vert\Omega_{n-1}, d_n=1\right)\\\ 
        &=V^H\frac{\theta_{n-1}\mathbb{P}\left(d_n\vert V^H\right)}{\theta_{n-1}\mathbb{P}\left(d_n\vert V^H\right) + \left(1 -\theta_{n-1}\right)\mathbb{P}\left(d_n\vert V^L\right)} + V^L \frac{\left(1 -\theta_{n-1}\right)\mathbb{P}\left(d_n\vert V^L\right)}{\theta_{n-1}\mathbb{P}\left(d_n\vert V^H\right) + \left(1 -\theta_{n-1}\right)\mathbb{P}\left(d_n\vert V^L\right)}.
    \end{aligned}
\\]
As done in the previous post, let's use the total probability formula with the events $\{I\}$ for the informed trader and $\{U\}$ for the uniformed trader. Let's start with 
\\[
    \begin{aligned}
        \mathbb{P}\left(d_n\vert V^H\right) &= \mathbb{P}\left(d_n\vert V^H, I\right)\mathbb{P}\left(I\vert V^H \right) + \mathbb{P}\left(d_n\vert V^H, U\right)\mathbb{P}\left(U\vert V^H \right)\\\ 
        &=\frac{1}{2}\mathbb{P}\left(d_n\vert V^H, I\right) + \frac{1}{2}\mathbb{P}\left(d_n\vert V^H, U\right) \\\ &=\frac{1}{2}\mathbb{P}\left(d_n\vert V^H, I\right) + \frac{1-\pi}{2}
    \end{aligned}
\\]
To compute $\mathbb{P}\left(d_n\vert V^H, I\right)$ we observe that the informed trader will act based on the signal,
let's condition on the signal being correct or wrong
\\[
    \begin{aligned}
        \mathbb{P}\left(d_n\vert V^H, I\right) &= \mathbb{P}\left(d_n\vert V^H, I, C\right)\mathbb{P}\left(C\vert V^H, I \right) + \mathbb{P}\left(d_n\vert V^H, U, W\right)\mathbb{P}\left(W\vert V^H, U  \right)\\\ &= 1 \cdot\rho\cdot\pi + 0.
    \end{aligned}
\\]
The last equality comes from the fact that if the signal is correct and the value is $V^H$ then the signal is saying 
"buy" and the informed trader buys with probability $1$. While if the signal is wrong it is saying "sell", thus the 
informed trader will not buy. Putting it together, this gives
\\[
    \mathbb{P}\left(d_n\vert V^H\right) = \frac{\left(2\rho-1\right)\pi+1}{2}
\\]
Similarly, we obtain
\\[
    \mathbb{P}\left(d_n\vert V^L\right) = \frac{\left(1-2\rho\right)\pi+1}{2}.
\\]
Differently from what we had in the perfect information case, here the informed trader contributes to 
$\mathbb{P}\left(d_n\vert V^L\right)$ when the signal is wrong. If we set $\rho=1$ we recover the formulas we got for 
the perfect information case. To simplify the notation and make clear that the math is analogous to the model with
perfectly informed traders we set $\tilde{\pi}:=(2\rho-1)\pi$  

Substituting into the expression we had for $a_n$, we get
\\[
    \begin{aligned}
        a_n &= V^H\frac{\frac{\left(2\rho-1\right)\pi+1}{2}\theta_{n-1}}{\frac{\left(2\rho - 1\right)\pi\ + 1}{2}\theta_{n-1} + \frac{\left(1-2\rho\right)\pi + 1}{2}\left(1-\theta_{n-1}\right)} 
        +\\\ &\ \ \ \ \ V^L\frac{\frac{\left(1-2\rho\right)\pi+1}{2}\left(1-\theta_{n-1}\right)}{\frac{\left(2\rho - 1\right)\pi\ + 1}{2}\theta_{n-1} + \frac{\left(1-2\rho\right)\pi + 1}{2}\left(1-\theta_{n-1}\right)}
         \\\ &=  V^H\frac{\frac{\tilde{\pi}+1}{2}\theta_{n-1}}{\frac{\tilde{\pi} + 1}{2}\theta_{n-1} + \frac{-\tilde{\pi} + 1}{2}\left(1-\theta_{n-1}\right)} 
        +\\\ &\ \ \ \ \ V^L\frac{\frac{-\tilde{\pi}+1}{2}\left(1-\theta_{n-1}\right)}{\frac{\tilde{\pi}\ + 1}{2}\theta_{n-1} + \frac{-\tilde{\pi}+ 1}{2}\left(1-\theta_{n-1}\right)}
         \\\ &= V^H\frac{\frac{\tilde{\pi}+1}{2}\theta_{n-1}}{\tilde{\pi}\theta_{n-1} +\frac{1-\tilde{\pi}}{2}} + V^L\frac{\frac{1-\tilde{\pi}}{2}(1-\theta_{n-1})}{\tilde{\pi}\theta_{n-1} + \frac{1-\tilde{\pi}}{2}} 
    \end{aligned}
\\]

We notice that the result for $a_n$ has the same functional form as the one obtained in the perfect information case.
It follows that the spread will have the same functional form. Thus, we can directly write

\\[
    \begin{aligned}
        S_n &= a_n - b_n = \tilde{\pi} \theta_{n-1}(1-\theta_{n-1})\left(\frac{1}{\tilde{\pi}\theta_{n-1} + \frac{1-\tilde{\pi}}{2}}+\frac{1}{\tilde{\pi}(1-\theta_{n-1}) + \frac{1-\tilde{\pi}}{2}}\right)\left(V^H - V^L\right) \\\ 
            &= \left(2\rho-1\right)\pi \theta_{n-1}(1-\theta_{n-1})\left(\frac{1}{\left(2\rho-1\right)\pi\theta_{n-1} + \frac{1-\left(2\rho-1\right)\pi}{2}}+\frac{1}{\left(2\rho-1\right)\pi(1-\theta_{n-1}) + \frac{1-\left(2\rho-1\right)\pi}{2}}\right)\left(V^H - V^L\right).
    \end{aligned}
\\]

The only difference with the standard case is the presence of the term $\left(2\rho-1\right)$. This term is another
factor of uncertainty for the market maker. This new source of uncertainty increases with $\rho$, meaning that the
better informed the informed trader is, the wider the market maker should quote the spread.
As promised at the beginning, by setting $\rho=1$ we recover the perfectly informed case. 
Interestingly, for $\rho\rightarrow\frac{1}{2}$ we have $S_n\rightarrow0$. This shows that in the absence of
better informed traders perfect competition between market makers would drive the spreads to $0$.