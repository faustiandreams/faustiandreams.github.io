---
layout: post
tags: market_making paper_explained
mathjax: true
excerpt: Introduction to equilibrium strategies for market participants
title: "Kyle model"
---


1985, what a great year for market making. Together with the Glostem-Milgrom model (GM from now), the seminal paper 
{% cite kyle_continuous_auction %} was published: Kyle model was born. 
Both papers build on the classification of the market participants into informed, uninformed and market makers. 
We refer to this [post]({{ site.baseurl }}{% link _posts/2022-08-23-glosten-milgrom-model.md %}) 
for an explanation of these categories. <br>  While the GM model is sequential and focuses on the determinants of the 
bid-ask spread, Kyle model is more geared towards optimal strategies for the market maker and the informed trader
(sorry uninformed folks). What makes this model interesting is that it takes into account strategic behavior. 
Market participants are aware of the others' objectives and information, and they strategically react to this awareness. 
In the GM model we already saw that the market maker is trying to make 
inference about the source of the market orders. In this model the informed trader will play strategically as well. 
Specifically, he is aware that other market participants will try to extract as much value as possible from his actions
and eat into his projected profit. He needs to choose his actions to make the other players as uncertain as possible about
the extent of his presence in the market. While the informed trader will choose his strategy to maximise his profit, 
the market maker will choose the way to price the asset s.t. his expected profit is $0$. This last condition 
is usually explained through perfect competition between market makers, and ensures that the market maker is providing
to the market the best price available given the current information.

In this model we have one trading period which is divided in two steps. 

- In the first step the informed trader and the uninformed traders decide how much of the asset they want to trade (either buy or sell). There is only one informed trader, but the number of  uninformed traders does not matter since we are going to consider their cumulative order. The uninformed trader is assumed to trade randomly, and the amount he trades follows a Gaussian distribution (we will get into the formalisation of this later). The informed trader knows the value the asset will have at the end of the period but does not know the size of the aggregate order from the uninformed trader, he only knows the parameters of its distribution. 
- In the second step the market maker observes the total order (from informed and uninformed) and has to name a price to take the opposite side of the trade. He does not know which proportion of the order comes from the informed trader and which proportion of the order comes from the uninformed trader.  He also does not know the value of the asset. His goal is to price the asset "fairly" so that he is comfortable clearing the market at that price. 

<br>  

<h2>
  Assumptions and notation
</h2>

- All trading activity occurs within a single period, which is structured in two sequential steps.
- The uninformed trader chooses (randomly) to submit an order of size $u$. We assume $u\sim\mathcal{N}(0, \sigma^2_u)$ and $u$ is independent of all the other random variables.
- The informed trader knows the asset's final value $V$ and the parameters of the uninformed order distribution, $\sigma^2_u$. Crucially, in equilibrium, the informed trader knows the market maker's pricing function $P(q)$ and chooses their order size $x=X(V)$ to maximize their expected profit given this rule. They do not know the realized uninformed order $u$ when choosing $x$.
- For the market maker the value of the asset is a random variable following the distribution $\mathcal{N}(p_0, \sigma^2_{p_0})$. 
  He observes the quantity $q:=u+x$ but not $u$ or $x$. The market maker has to decide the price for $q$ so that he can clear the market. We assume the existence of only one market maker, who is risk neutral and prices the asset such that his expected profit is $0$. This condition will make the pricing depend only on the order flow.

<br>  


<h2>
  Notion of equilibrium
</h2>
The informed trader and the market maker have to choose how to play their hand. 
The informed trader needs to choose a strategy, $X$, and the market maker needs to choose a pricing function $P$.
Let's use the assumptions above to derive a meaningful notion of equilibrium for the two agents. An equilibrium
will involve a strategy for the informed trader and a pricing function s.t. the informed trader maximizes his
expected profit, given the pricing function; the market maker profit is one average $0$, given the insider
strategy.

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


*Definition* We call equilibrium a couple of (measurable) functions $(\bar{X}, \bar{P})$ such that:

**1.** $\mathbb{E}\left[\Pi(\bar{P}, \bar{X})(V, u)\vert V\right]\ge\mathbb{E}\left[\Pi(\bar{P}, X')(V, u)\vert V\right]$, for all (measurable)
functions of the value of the asset $X'$. With this condition, we require the equilibrium strategy of the insider
to be optimal in expectation (over $u$), compared to any other strategy $X'$, assuming the equilibrium pricing $\bar{P}$ is used.

**2.** $\bar{P}\left(q\right)=\mathbb{E}[V\vert q=\bar{X}(V)+u]$. Not surprisingly we
require the equilibrium pricing function to be equal to the expectation of the value of the asset given the order flow.
This means that this pricing is efficient based on the information contained in $q$.




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
This theorem is remarkable in the sense that it gives a full characterisation of the equilibrium in the affine case. <br> 
The parameter $\beta$ controls how aggressive the informed trader will be in placing his order. We observe that this 
parameter increases with $\sigma_u^2$, which means the more uncertainty there is about the order the uninformed trader 
will submit, the more comfortable the informed trader is to submit a large order. This result tells us that the informed 
trader is using the uniformed order flow to hide his intentions. <br> 
The parameter $\lambda$ is related the impact the order size has on the market. Specifically  $\frac{1}{\lambda}$ 
measures the amount of order flow needed to increase the price by one dollar. $\frac{1}{\lambda}$ is directly proportional 
to the market depth, meaning the larger this amount is, the less impact large volume has on the price. $\lambda$ is the
price sensitivity in the market maker strategy; a larger value of $\lambda$ means that the market maker reacts more to 
the information present in the order flow, as if he was not too certain about his a priori estimate of the asset value.
We notice that there are two different types of factor determining how much the market maker will react to the volume traded. 

- $\sigma_{p_0}$ at the numerator tells us that the larger the uncertainty about the a priori estimate of the value of the asset (that is before observing any order flow), the more the market maker should update his best guess about the value of the asset after seeing the order flow. 
- $\lambda$ is inversely proportional to $\sigma_{u}$. A larger $\sigma_{u}$ means more unpredictable noise trading. This makes it harder for the market maker to distinguish between informed volume and noise. Therefore, the market maker learns less from each unit of observed order flow $q$, and they react less aggressively by changing the price less per unit of $q$


<br>  
<h2>
    Conclusion
</h2>
The Kyle model provides a foundational framework for understanding strategic trading and price formation under asymmetric information. Unlike the Glosten-Milgrom model, which focuses on sequential trade and the bid-ask spread arising from adverse selection, Kyle highlights how a strategic informed trader chooses the size of their trade to maximize profit while considering its impact on the price. The model introduces key concepts like the informed trader's aggressiveness (β, showing how they hide behind noise) and market depth or price impact (λ, showing how order flow moves prices as information is revealed). The equilibrium price Pˉ(q) dynamically incorporates the information inferred from the total order flow q.

However, like any theoretical model, the Kyle model relies on significant simplifying assumptions to achieve its elegant, solvable form. Several of these assumptions are not fully realistic representations of actual financial markets:
- **Single Period and Single Informed Trader**: Real markets are continuous with numerous traders, potentially many of whom are informed and compete with each other.
- **Perfect Information and Knowledge**: The assumption that the informed trader knows the final asset value V with certainty, knows the exact distribution of uninformed trades u, and, crucially for the equilibrium, knows the market maker's precise pricing function P(q), is a strong simplification. In reality, information is less perfect, distributions are unknown, and market participants' strategies are proprietary and dynamic.
- **Exogenous Noise Trading**: Uninformed trading is modeled simply as random noise. In reality, "uninformed" traders have diverse reasons for trading (hedging, liquidity needs, portfolio rebalancing), and their behavior can be complex and correlated.
- **Passive Market Maker**: The market maker is reactive, simply setting the price based on observed order flow to achieve zero expected profit. Real market makers actively manage inventory risk, have varying degrees of competitiveness, and employ more complex trading strategies.
- **Specific Distributions**: The reliance on Gaussian distributions for V and u is mathematically convenient but doesn't capture the fatter tails often observed in financial data.

Despite these simplifications, the Kyle model remains incredibly valuable. It provides a clear and tractable illustration of fundamental market microstructure dynamics: how strategic information trading occurs, how information gets impounded into prices through order flow, and what determines the sensitivity of price to volume (price impact/market depth). It serves as a crucial theoretical benchmark and a building block for understanding more complex real-world market phenomena. The concepts of strategic information revelation and price impact derived from Kyle are cornerstones of modern market microstructure theory.

<br>

## References
{% bibliography --cited %}
