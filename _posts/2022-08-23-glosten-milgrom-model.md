---
layout: post
tags: market_making paper_explained
mathjax: true
excerpt: How do the markets digest information? Introduction to the Glosten Milgrom model
title: "Glosten Milgrom model"
---

We are interested in understanding how new information is assimilated by the markets. 
The strong form of the efficient market hypothesis (EMH) states implies that if there is any change in the value of the 
asset (either due to news release, change in macroeconomic outlook etc.), all market participants will reach consensus, 
instantaneously, about the new value of the asset, and trading activity will occur at a price that reflects value. 
There are many critics to the strong form of the EMH, and whoever has any trading experience figured out that there is 
a lot of activity happening as "price is trying to find value". In my view the strong form of the EMH is analogous to 
Newtonian dynamics without friction: A useful, albeit too idealised, model for the world.  
We follow the original article {% cite glosten_milgrom_1985 %} as well as the exposition of 
{% cite ohara_market_microstructure %} and {% cite foucault_market_making_book %}
        

<br>  

<h2>
    Types of market fauna
</h2>

The GM model falls in the category of information based model. 
In this model there are three type of market participants: informed traders, uninformed traders and market makers. 
The high level distinction between the three groups is their ability to assess the true value of an asset. 

- The market maker (also called liquidity provider or dealer) is the person (people) responsible for providing bid and 
  ask prices at each point in time. The market maker is not interested in holding the asset and his business is based on 
  matching buyers and sellers who want to trade at different times. His profit is determined by the 
  bid-ask spread. In this model the market maker does not know the true value of the asset.
- The uninformed trader (also noise trader or liquidity trader) trades for reasons that are not related to the true 
  value of the asset. GM does not model his reason for trading, but it models the probability that he will show up for 
  a trade and the direction of the trade (more on this later).
- The informed trader (also called speculator or insider) is able to better estimate the true value of the asset. 
  We don't model the reason for his knowledge edge. He engages in trading only when the market maker is quoting prices 
  that differ from the true value. 

  

At this point some questions arise: How is the market maker profit generated if informed traders are always making 
money off him? How are bid and ask prices quoted (is the bid-ask spread even positive)? 
What should the market maker do to improve his estimate of value? We can answer the first question immediately and 
answer the others (and related questions by the end).  



<br>  

<h2>
    Few neat remarks    
</h2>

*Observation* We assume the market maker to be risk neutral and perfectly competitive. 
By perfectly competitive we mean that if there are multiple market makers they will try to undercut each other by offering
a tighter bid-ask spread, as long as the expected profit for doing so is positive. 
This assumption pushes the bid-ask spread towards $0$.

*Observation (following, to some extent, Bagehot 1971)* In the market food chain it is clear from the above characterisation
that the informed trader eats the market maker (at least statistically).  We call adverse selection the practice of being
picked up for a trade by a better informed counterpart. This means that to avoid extinction the market maker need to feed 
on a different creature. You guessed it, it's the uninformed trader. The way this works is that when quoting bid and ask 
prices the market maker should account for the fact the he needs to make up for the (losing) trades against the speculator.
Adverse selection (and ultimately the presence of informed traders) has the opposite effect of perfect competition: 
it pushes the bid-ask spread towards large values.

*Observation* The market maker does not know the identity of the market participants, but, for each trade, he knows
the probability  that the trade comes form an informed trader. He also knows that the informed trader has better
information than him, so he can use this fact to sequentially infer the true value of the asset. In this setup trades are the mean
that conveys information to the markets (technically only the informed ones, but since we can't tell them apart we have
to consider all of them). By observing the order flow the market maker can extract information about
the (unknown) value of the asset.    
  
       
<br>   

<h2>
    Assumptions and notation
</h2>

- The asset value $V$ is a random variable. We assume trading to happen within one period, characterised by $N$ iterations.
- We make a simplifying assumptions: the market maker knows that the value of the asset at the end of the trading period
  can assume one of two values $V^H$ or $V^L$ (high or low), with $V^H > V^L$. This assumption allows for simpler 
  computations without crippling the conclusions of the model.
- At each iteration $n$ there is a trade happening. We denote by $d_n$ the signed trade size. In GM trades are set to 
  be of unit size, which amount to set
  \\[
    d_n = \begin{cases}1\ \text{if the order is buy}\\\ -1\ \text{if the order is sell}.\end{cases}
  \\]   
  The order flow information  is the only observable for the market maker (he is not considering the price history or his pnl).
  We denote the order flow information by $\Omega_n := \\{d_1, \dots, d_n\\}$. Based on this information the dealer is going 
  to update his belief (Bayesian learning, anybody?) about the asset value.
- The model is sequential. We have a total of $N$ iterations. The first action in the period is the dealer quoting bid and ask prices. 
  We call $a_n$ the ask price and $b_n$ the bid price. It is logical to quote $a_n$ and $b_n$ around the expected value of the asset, 
  given the order flow observed so far. Since the $n-$th trade still hasn't happened, the dealer should condition on $\Omega_{n-1}$. 
  However, sine we know that the $n-$th trade is going to be either buy or sell, we assume the dealer to ask himself 
  "At what price should I sell (buy) given the orders that I have seen so far, and assuming the next trade is going to be a buy (sell)?". 
  So the dealer is already factoring in the possible direction of the next trade and he is happy with the quotes he is providing.
  We refer to this by saying that the dealer quotes with no regrets. Formally, we define 
  \\[
    \begin{align}
      a_n &:= \mathbb{E}[V\vert\Omega_{n-1}, d_n=1] \\\  
      b_n &:= \mathbb{E}[V\vert\Omega_{n-1}, d_n=-1]
    \end{align}  
  \\]
    Notice that from this definition alone it is not clear if $a_n>b_n$. We will have to prove this fact!
- The next thing that happens at iteration $n$ is the trade. Of course the market maker does not know the identity of 
  the next trader. We model this by assuming to sample either an informed trader, with probability $\pi$ or an uninformed 
  trader, with probability $1-\pi$. The uninformed trader is assumed to trade randomly and buy or sell with probability 
  $\frac{1}{2}$. The informed trader buys only when he has statistical hedge: he buys with probability $1$ if the ask 
  price is below the expected value of the asset and sells with probability $1$ if the expected value of the asset is 
  below the bid price. We assume that the probability of the $n$-th trade to be a buy or a sell to be conditionally 
  independent of $\Omega_{n-1}$, given $V$.
- After the trade the market maker can review his belief about the value of the asset. We start by recalling that our 
  first assumption was about the value of the asset at the end to be $V^L$ or $V^H$. The market maker assigns probability 
  to the events $\{V=V^L\}$ and $\{V=V^H\}$. Formally, 
  \\[
    \theta_n:=\mathbb{P}(V=V^H\vert\Omega_n).
  \\]
   We also define the dealer's expectation of the asset value given the observed order flow
  \\[
    \begin{aligned}
      \mu_n:= \mathbb{E}[V\vert\Omega_n].
    \end{aligned}
  \\]
  Notice that we can use the law of total probability to get
  \\[
    \begin{aligned}
      \mu_n &= \mathbb{E}[V\vert\Omega_n, V=V^L]\mathbb{P}(V=V^L\vert\Omega_n)+\mathbb{E}[V\vert\Omega_n, V=V^H]\mathbb{P}(V=V^H\vert\Omega_n) \\\ &
      = V^L (1 - \theta_n) + V^H\theta_n.
    \end{aligned}
  \\]
- An equilibrium for this model involves a strategy for the informed trader and the computation of the bid and ask quotes 
  for the market maker. 

       
<br>   

<h2>
    Informed trader
</h2>

The strategy of the informed trader is straightforward. For each iteration he knows $a_n$ and $b_n$ and the value of the 
asset. He is going to buy if the market maker is selling at low price and buy if the market maker is buying at a high 
price. Formally his strategy is:

- Buy if $V>a_n$;
- Sell if $V<b_n$;
- Do nothing otherwise.

       

<br>   
<h2>
    Market maker
</h2>

There are different methods to compute the bid and ask prices and to get the spread for the market maker. One way is to 
compute the expected profit for the market maker when somebody is buying and set this to $0$ due to perfect competition.
This method is used in {% cite foucault_market_making_book %}.
Instead, we proceed by directly computing the ask price from the definition, using the law of total probability and Bayes formula.
\\[
  \begin{aligned}
    a_n &= \mathbb{E}[V\vert \Omega_{n_1}, d_n=1]  \\\  
    & =V^H\mathbb{P}(V=V^H\vert\Omega_{n-1}, d_n=1)+ V^L\mathbb{P}(V=V^L\vert \Omega_{n-1},d_n = 1) \\\  
  \end{aligned},
\\]
where we used only the law of total probability. Let's focus on the first term of the sum 
\\[
  \begin{aligned}
    V^H\mathbb{P}(V=V^H\vert\Omega_{n-1}, d_n=1) &= V^H\frac{\mathbb{P}(d_n=1\vert\Omega_{n-1}, V=V^H)\mathbb{P}(\Omega_{n-1}, V=V^H)}{\mathbb{P}(\Omega_{n-1}, d_n=1)} \\\  
    & = V^H\frac{\mathbb{P}(d_n=1\vert\Omega_{n-1}, V=V^H)\mathbb{P}(V=V^H\vert\Omega_{n-1})}{\mathbb{P}(d_n=1\vert\Omega_{n-1})}
  \end{aligned}
\\]
It is clear that we get a similar formula for the $V=V^L$ part. 
From the above definitions we have $\mathbb{P}(V=V^H\vert\Omega_{n-1}) = \theta_{n-1}$. To compute the denominator 
we condition on $V^H$ and $V^L$ and notice all is left to compute is the other term at the numerator 
(the denominator is just the sum of the conditional probability of the next trade given $V$). 
Let's focus on the case $V=V^H$ as the other one is analogous. From the assumption of conditional independence we have
\\[
  \mathbb{P}(d_n=1\vert\Omega_{n-1}, V=V^H)=\mathbb{P}(d_n=1\vert V=V^H).
\\]
Conditioning on the trade coming from an informed (event I) or uninformed (event U) trader we get
\\[
  \begin{aligned}
    \mathbb{P}(d_n=1\vert V=V^H) &= \mathbb{P}(d_n=1\vert V=V^H, I)P(I\vert V^H) + 
    \mathbb{P}(d_n=1\vert V=V^H, U)P(U\vert V^H) \\\  &= 1\cdot\pi + (1-\pi) \cdot \frac{1}{2} = \frac{1+\pi}{2}.
  \end{aligned}
\\]
Which comes from the fact that the uninformed trader buys randomly with probability $\frac{1}{2}$, while the informed 
trader buys with probability $1$ conditional on the value of the asset being high. 
Similarly, we get
\\[
  \begin{aligned}
    \mathbb{P}(d_n=1\vert V=V^L) = 0\cdot\pi + (1-\pi) \cdot \frac{1}{2} = \frac{1-\pi}{2}.
  \end{aligned}
\\]
since the informed trader does not buy if the value is low.
Putting it all together we get 
\\[
  \begin{align}a_n &=V^L\frac{\frac{1-\pi}{2}(1-\theta_{n-1})}{\pi\theta_{n-1} + \frac{1-\pi}{2}} + V^H\frac{\frac{\pi+1}{2}\theta_{n-1}}{\pi\theta_{n-1} +\frac{1-\pi}{2}} \\\ 
    &=\mu_{n-1}+\frac{\pi\theta_{n-1}(1-\theta_{n-1})}{\pi\theta_{n-1} +\frac{1-\pi}{2}}\left(V^H-V^L\right),
  \end{align}
\\]
where the second equality is obtained by adding and subtracting 
\\[
  V^L\frac{\pi\left(1-\theta_{n-1}\right)\theta_{n-1}}{\pi\theta_{n-1} +\frac{1-\pi}{2}},
\\]
and  
\\[
  V^H\frac{\pi\left(1-\theta_{n-1}\right)\theta_{n-1}}{\pi\theta_{n-1} +\frac{1-\pi}{2}}.
\\]

Analogously we get 
\\[
  b_n = \mu_{n-1} - \frac{\pi\theta_{n-1}(1-\theta_{n-1})}{\pi(1 -\theta_{n-1}) +\frac{1-\pi}{2}}\left(V^H-V^L\right).
\\]
We from these formulas we can easily prove $a_n > b_n$.
The bid-ask spread is 
\\[
  S_n = a_n - b_n = \pi \theta_{n-1}(1-\theta_{n-1})\left(\frac{1}{\pi\theta_{n-1} + \frac{1-\pi}{2}}+\frac{1}{\pi(1-\theta_{n-1}) + \frac{1-\pi}{2}}\right)\left(V^H - V^L\right).
\\]
       


<br>   

<h2>
    The composition of the bid-ask spread
</h2>

Now that we have an explicit formula for the spread we can get a better understanding of why the market maker is asking
for positive compensation, that is setting a positive spread.

- The spread increases with $\pi$, the proportion of informed traders. This means that the market maker is charging for 
  the risk he faces of being adversely selected. It is clear that the uninformed traders are paying this cost. We observe
  that the presence of informed traders is enough for the model to explain positive bid-ask spreads.
- The spread depends on $\theta$ and $(1 - \theta)$, that is the belief the market maker has about the value of the 
  asset being close to $V^H$ or $V^L$ . The spread is a function of this uncertainty, the larger the uncertainty the 
  larger the spread. This component is maximised for $\theta=\frac{1}{2}$, which corresponds to maximum uncertainty about 
  the asset value. If the market maker knew that $V=V^H$ then all this discussion could have been avoided as he should 
  only quote $a$ and $b$ such that $a<V^H<b$, and perfect competition would push the bid-ask spread to $0$.
- The third component of the bid-ask spread is $V^H-V^L$, the range of variation of the asset value. The presence of this
  term can be understood considering that the wider the range, the more the market maker is losing against informed 
  investors. For instance assume the market maker is quoting prices close to $V^L$ with the actual value being $V^H$. 
  Then, in the process of learning the true value of the asset from the order flow, the market maker is accepting a 
  loss $\approx V^H -V^L$(at least for the first trades).

We can summarise the factors that contribute to the bid-ask spread under one common concept: uncertainty. 
The more uncertain the market maker is about the inference he can make about the market, the more he will charge for
the possibility of being on the wrong side of the trade.
       

<br>   
<h2>
    Belief update
</h2>

In the above computation of the ask price and bid prices after conditioning we got the quantities 
$\mathbb{P}(V=V^H\vert \Omega_{n-1}, d_n = 1)$ and $\mathbb{P}(V=V^L\vert \Omega_{n-1}, d_n = -1)$. Let's call 
$\theta_n^+$ the first one and $\theta_n^-$ the second one. First we notice that $\theta_n^+>\theta_{n+1}^-$, which
means that if a buy order is observed the dealer will conclude that the value of the asset is higher that his current best
guess. His new best guess, after seeing a buy order is
\\[
  \mu_n^+ =\theta_n^+V^H + (1-\theta_n ^+)V^L.
\\]
If we now substitute $\mu_{n-1}$ using the definition, and the value of $\theta_n^+$ from two paragraphs ago, we can easily compute 
\\[
  \mu_n^+ - \mu_{n-1} = \frac{\pi\theta_{n-1}(1-\theta_{n-1})}{\pi\theta_{n-1}+ \frac{1-\pi}{2}}\left(V^H - V^L\right).
\\]
Comparing this expression with what we got for $a_n$ we can easily get $a_n=\mu_n^+$, which means that if a buy order 
were to come, the best guess for the value of the asset would be $\mu_n^+$; so it is logical for the market maker to 
already price the asset at $\mu_n^+$ (this is a more formal way to say that he is quoting with no regret). 
       

<br>   
<h2>
    Conclusion
</h2>
The model is very interesting, as with very simple assumptions it is able to reproduce some phenomena seen in the markets 
and explain them. We have seen that there are different types of risks the maker-maker bears, all coming from information
disadvantage. This is enough for the market maker to quote positive spreads just to break even. Since the market maker 
is just breaking even, this means that the profits made by the informed traders are paid by the uninformed traders. 
The model is also Bayesian in nature and it shows how the information content of the trades affects the beliefs of the 
market maker, and ultimately the prices available to buy and sell. The model also presents a simple mechanism that 
explains how information is assimilated by the markets, which sounds more reasonable than the 
"information propagates immediately" conclusion of the EMH. We won't get into it, but it can be proved that while the 
model does not satisfy the strong form of the EMH (in general), it does satisfy the semi-strong version of it.

It is clear that the model is highly stylized and some hypothesis are too strong. Let's go through some of them.
The model assumes the value of the asset to be fixed within the period and all informed traders to know it with 
certainty, which is not very realistic. In the real world even informed traders can have different estimates for the 
value of the asset. Interestingly this would imply that the bid-ask spread is being paid also by some informed traders, 
when there is disagreement about the value of the asset. The trade size is assumed to be $1$, which greatly simplifies 
the computation, but ignores the importance of volume as source of information.
 

<br>   
<h2> References</h2>
{% bibliography --cited %}
