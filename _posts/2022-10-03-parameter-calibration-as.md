---
layout: post
tags: market_making paper_explained
mathjax: true
excerpt: Calibration procedure for $\Lambda$ and $k$ in the AS model
title: "Parameter calibration in Avellanda-Stoikov"
---

The Avellanda-Stoikov (AS for short) model for market making is a classical example of how to approach market making
as a stochastic control problem. We will assume familiarity with the framework and 
focus on estimating the parameters discussed in section "2.5" of {% cite avellaneda_stoikov_mm_model %}.

In AS it is assumed that execution of limit orders follows a Poisson distribution with intensities $\lambda^a$ for the ask side and $\lambda^b$ for the bid side. Since orders further away from the best quotes have a lower chance of being executed the intensities are a function of the depth of the limit order. More formally, if $P^a$ is the ask price of the order and $m$ is the mid-price, we set $\delta^a=P^a-m$ and reformulate the previous sentence saying that $\lambda^a$ depends on $\delta^a$, i.e. $\lambda^a=\lambda^a(\delta^a)$. Similarly for the bid side. We are interested in estimating the intensities from the data. 

The reasoning in the paper follows from several empirical results about price impact and order density, and it goes as follows:

> It has been empirically verified that price impact as a function of order size behaves in the following way
> \\[\Delta P\approx\ln(Q),\\]
> with $Q$ order size. Thus, if we know the distribution of the order sizes, we can link the incoming orders to the probability of being executed at some depth $\lambda^a(\delta^a)$.
> Luckily researchers have empirically verified that the size of incoming orders has density
> \\[f^Q(x)\approx x^{-1-\alpha}.\\]

Let's put these two facts together. For simplicity (following the paper) we assume a constant frequency $\Lambda$ of buy or sell orders
We also call $\frac{1}{K}$ the constant such that $\Delta P=\frac{1}{K}\ln(Q)$.

Let's focus on the ask side. We can write 
\\[
    \begin{align}
        \lambda^a(\delta^a)&=\Lambda\mathbb{P}(\Delta P > \delta^a)\\\ 
        &= \Lambda\mathbb{P}(\ln(Q)>K\delta^a) \\\ 
        &= \Lambda\mathbb{P}(Q>e^{K\delta^a})\\\ 
        &=\alpha\Lambda e^{\alpha K\delta^a}, \label{a}\tag{1}
    \end{align}
\\]
where the last equality follows from an easy integration. We set $A=\frac{\Lambda}{\alpha}$ and $k=\alpha K$. Similarly for the bid side.

This result gives us a functional form for the intensity, and we will use this functional form and market data to estimate $A$ and $k$, as 
 described in {% cite laruelle_parameter_estimation %}, {% cite kch_avellanda_stoikov %} and {% cite naz_avellanda_stoikov %}.
As above, we focus only on the ask side.

- We pick a time $t_0$ and record the mid-price at $t_0$, say $m(t_0)$.
- We look for the first time $\bar{t}(t_0)=\inf\\{t\in[t_0, T]\ \vert\ \text{the order with price } P^a(t_0) \text{ is executed}\\}$ 
  and record both $\bar{t}(t_0)$ and  $\delta^a(t_0)$. The maximum time limit, $T$, has been added to prevent the search from running forever.  
  Here we are assuming we posted an order at price $P^a(t_0)$ and we are interested to know how long it takes for the order to be executed.
  As observed by Lehalle in {% cite kch_avellanda_stoikov %}, 
  there are some choices to make at this point, related to our order not actually being on the orderbook.  
  First, we need to decide what to do if $P^a(t_0)$ is smaller than the actual best ask observed in the data, which can happen if
  the bid-ask spread is wider than its minimum value.  
  Second, we need to choose a definition for the currently vague notion of an order "being executed". Strictly speaking to consider a limit order executed 
  a market order has to hit it; this definition of "being executed" can be tricky to compute. Another possibility is to
  just look for the mid-price to cross the price of the limit order. This latter characterization is easy to compute,
  but in general does not guarantee the order would have been executed, as the mid-price can move due to cancellations.
- We repeat the steps above for various initial times. Each choice provides a couple $(\delta^a(t_i), \bar{t}(t_i) - t_i)$. 
  We observe that for each  $\delta^a(t_i),$ there can be multiple values of  $\bar{t}(t_i) - t_i$. Let's call the set of 
  these inter-arrival times $\Gamma_{t_i}(\delta^a)$. Since we are assuming the elements of $\Gamma_{t_i}(\delta^a)$ to come 
  from a Poisson distribution with parameter $\lambda^a(\delta^a)$, we can estimate $\lambda^a(\delta^a)$ with the average 
  over $\Gamma(\delta^a)$, which we denote by $\langle\Gamma_{t_i}(\delta^a)\rangle$.
- If we plot the points $I = \\{(\delta^a(t_i), \langle\Gamma_{t_i}(\delta^a)\rangle),  i\geq 0\\}$, the resulting plot should be similar
  to {% cite laruelle_parameter_estimation %} and {% cite naz_avellanda_stoikov %}.
  To estimate $A$ and $k$ we consider two points from $I$ and fit an exponential of the same form of $(1)$. Let's call
  $\delta^a(t_j),\ \delta^a(t_l)$ the $x$-axis component of these points. With simple math
  we get the relationships
  \\[\begin{cases}&k= \frac{1}{\delta^a(t_l) - \delta^a(t_j)}\log\left(\frac{\lambda(\delta^a(t_l))}{\lambda(\delta^a(t_j)}\right)\\\ \\\ &A=\lambda(\delta^a(t_j)) e^{k\delta^a(t_j)}\end{cases}.\\]
  We conclude by noticing that since points are in $I$ we have $\lambda(\delta^a(t_l))=\langle\Gamma_{t_l}(\delta^a)\rangle$ and $\lambda(\delta^a(t_j))= \langle\Gamma_{t_j}(\delta^a)\rangle$.


<br>  

## References
{% bibliography --cited %}
