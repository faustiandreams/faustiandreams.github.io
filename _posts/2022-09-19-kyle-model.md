---
layout: post
tags: market_making paper_explained
mathjax: true
excerpt: hey there
title: "Kyle model"
---


1985, what a great year for market making. Together with the Glostem-Milgrom model (GM from now), the seminal paper 
{% cite kyle_continuous_auction %} was published: Kyle model was born. 
Both papers build on the classification of the market participants into informed, uninformed and market makers. 
We refer to this [post]({{ site.baseurl }}{% link _posts/2022-08-11-glosten-milgrom-model.md %}) 
for an explanation of these categories. While the GM model is sequential and focuses on the determinants of the 
bid-ask spread, Kyle model is more geared towards optimal strategies for the market maker and the informed trader
(sorry uninformed folks). What makes this model interesting is that it takes into account strategic behavior. 
Market participants "know" about the
role and the objectives of the other parties. In the GM model we already saw that the market maker is trying to make 
inference about the source of the market orders. In this model the informed trader will play strategically as well. 
Specifically, he is aware that other market participants will try to extract as much value as possible from his actions
and eat into his projected profit. He needs to choose is actions to make the other players as uncertain as possible about
the extent of his presence in the market. While the informed trader will choose his strategy to maximise his profit, 
the market maker will choose the way to price the asset s.t. his expected profit is $0$. So we are assuming the market 
maker not to charge anything on top of the best estimate for the asset he gets given the order flow.

In this model we have one trading period which is divided in two steps. 

- In the first step the informed trader and the uninformed traders decide how much of the asset they want to trade (either buy or sell). There is only one informed trader, but the number of  uninformed traders does not matter since we are going to consider their cumulative order. The uninformed trader is assumed to trade randomly, and the amount he trades follows a Gaussian distribution (we will get into the formalisation of this later). The informed trader knows the value the asset will have at the end of the period but does not know the size of the aggregate order from the uninformed trader, he only knows the parameters of its distribution. 
- In the second step the market maker observes the total order (from informed and uninformed) and has to name a price to take the opposite side of the trade. He does not know which proportion of the order comes from the informed trader and which proportion of the order comes from the uninformed trader.  He also does not know the value of the asset. His goal is to price the asset "fairly" so that he is comfortable clearing the market at that price. 

<br>  

<h2>
  Assumptions and notation
</h2>

- All trading activity happens in one period. As described above in this period there are no iterations, but only two steps.
- The uninformed trader chooses (randomly) to submit an order of size $u$. We assume $u\sim\mathcal{N}(0, \sigma^2_u)$ and $u$ is independent of all the other random variables.
- The informed trader knows the value $V$ the asset will have at the end of the period. He is not assumed to know the value of $u$, but he knows $\sigma^2_u$. We will see how this knowledge will play a role in his strategy. He also does not know the current price of the asset, or how the market maker is going to price it (he has access to the price history though). The order of the informed trader has size $x$, which depends on $V$, we denote this dependence by $x=X\left(V\right)$, where $X$ is a measurable function. 
- For the market maker the value of the asset is a random variable following the distribution $\mathcal{N}(p_0, \sigma^2_{p_0})$. 
  He observes the quantity $q:=u+x$ but not $u$ or $x$. The market maker has to decide the price for $q$ so that he can clear the market. We assume the existence of only one market maker, who is risk neutral and prices the asset such that his expected profit is $0$. This condition will make the pricing depend only on the order flow.

<br>  


<h2>
  Notion of equilibrium
</h2>
The informed trader and the market maker have to choose how to play their hand. 
The informed trader needs to choose a strategy, $X$, and the market maker needs to choose a pricing function $P$.
Let's use the assumptions above to derive a meaningful notion of equilibrium for the two agents. An equilibrium
will involve a strategy for the informed trader and a pricing function s.t. this couple is optimal (in the sense of Nash). @TODO verify claim

For a given price $p$ and some aggregate order flow $q$, the assumption of $0$ expected profit reads
\\[
\begin{equation}\mathbb{E}\left[ -(V-p)q \right] = 0. \end{equation}
\\]
From which it follows that $p=\mathbb{E}\left[V\vert q\right]$ (using the properties of conditional expectation).
This means that the market maker will price the asset with his best estimate of value given the current order flow. 
Furthermore, this tells us that the pricing of the asset is a function of the order flow, i.e. $p=P(q)=P(x+u)$.

We define the profit of the insider for a pricing function $P$ and a strategy $X$ as 
\\[
\Pi(P, X) := (V - P(q)) X(V).
\\]
Formally we should have written $\Pi(P, X)(V, q) := (V - P(q)) X(V)$ as both $X$ and $P$ are functions that need to
be evaluated on the value and the order flow respectively, but we follow the more agile notation of {% cite kyle_continuous_auction %}.


*Definition* We call equilibrium a couple of (measurable) functions $(\bar{X}, \bar{P})$ such that 
1. $\mathbb{E}\left[\Pi(\bar{P}, \bar{X})\vert V\right]>\mathbb{E}\left[\Pi(\bar{P}, X')\vert V\right]$, for all (measurable) 
functions of the value of the asset $X'$. With this condition, we require the equilibrium strategy of the insider
to be optimal in expectation, compared to any other strategy, assuming the equilibrium pricing is used.
2. $\bar{P}\left(\bar{X}\left(V\right)+u\right)=\mathbb{E}[V\vert \bar{X}(V)+u]$. Not surprisingly we
require the equilibrium pricing function to be equal to the expectation of the value of the asset given the order flow.
This means that this pricing is efficient.


<br>  


<h2>
  The linear solution
</h2>
We state without proof the theorem that describes one equilibrium in this setup.

*Theorem* There is a unique equilibrium such that $\bar{X}$ and $\bar{P}$ are affine functions, i.e.
\\[
\bar{X}(V) = \beta (V-p_0),\ \ \ \bar{P}(q)=p_0 +\lambda q,
\\]
where $\beta$ and lambda are constants such that 

\\[
  \begin{equation}
    \beta = \frac{\sigma_u^2}{\sigma_{p_0}^2}, \ \ \ \ \lambda = \frac{1}{2} \frac{\sigma_{p_0}}{\sigma_{u}}.
  \end{equation}
\\]
\\[\tag*{$\square$}\\]
This theorem is remarkable in the sense that it gives a full characterisation of the equilibrium in the affine case. 
Let's investigate the meaning of this equilibrium. 
The parameter $\beta$ controls how aggressive the informed trader will be in placing his order. We observe that this parameter increases with $\sigma_u^2$, which means the more uncertainty there is about the order the uninformed trader will submit, the more comfortable the informed trader is to submit a large order. This result tells us that the informed trader is using the uniformed order flow to hide his intentions.
The parameter $\lambda$ is related the impact the order size has on the market. Specifically  $\frac{1}{\lambda}$ measures the amount of order flow needed to increase the price by one dollar. $\frac{1}{\lambda}$ is directly proportional to the market depth, meaning the larger this amount is, the less impact large volume has on the price. $\lambda$ is the price sensitivity in the market maker strategy; a larger value of $\lambda$ means that the market maker reacts more to the information present in the order flow, as if he was not too certain about his a priori estimate of the asset value.
We notice that there are two different types of factor determining how much the market maker will react to the volume traded. 

- $\sigma_{p_0}$ at the numerator tells us that the larger the uncertainty about the a priori estimate of the value of the asset (that is before observing any order flow), the more the market maker should update his best guess about the value of the asset after seeing the order flow. 
- $\sigma_{u}$ is related to uncertainty about the uninformed trader order size. The reason this factor is at the denominator, despite being related to uncertainty, is that the more certain the market maker is about the uninformed trader order size, the more likely it is that the uninformed order is small and that the order flow is dominated by the informed order. In this circumstance, the market maker knows that he needs to be more drastic in reassesing the asset value and choosing how to price it.

<br>  

## References
{% bibliography --cited %}
