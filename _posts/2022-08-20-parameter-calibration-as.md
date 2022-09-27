---
layout: post
tags: market_making paper_explained
mathjax: true
excerpt: hey there
title: "Parameter calibration in Avellanda-Stoikov"
---

The Avellanda-Stoikov (AS for short) model for market making is a classical example of how to approach market making
as a stochastic control problem. We will assume familiarity with the framework and 
focus on estimating the parameters discussed in section "2.5" of {% cite avellaneda_stoikov_mm_model %}.

In AS it is assumed that execution of limit orders follows a Poisson distribution with intensities $\lambda^a$ for the ask side and $\lambda^b$ for the bid side. Since orders further away from the best quotes have a lower chance of being executed the intensities are a function of the depth of the limit order. More formally, if $P^a$ is the ask price of the order and $m$ is the mid price, we set $\delta^a=P^a-m$ and reformulate the previous sentence saying that $\lambda^a$ depends on $\delta^a$, i.e. $\lambda^a=\lambda^a(\delta^a)$. Similarly for the bid side. We are interested in estimating the intensities from the data. 

The reasoning in the paper follows from several empirical results about price impact and order density. 
The reasoning goes as follows:

> It has been empirically verified that price impact as a function of order size behaves in the following way
> $$
> \Delta P\approx\ln(Q),
> $$
> with $Q$ order size. Thus if we know the distribution of the order sizes, we can link the incoming orders to the probability of being executed as some depth $\lambda^a(\delta^a)$.

It was empirically verified in [] that the size of incoming orders has density 
\\[
    f^Q(x)\approx x^{-1-\alpha}.
\\]
Let's put it all together. For simplicity (following the paper) we assume a constant frequency $\Lambda$ of buy or sell orders
We also call $\frac{1}{K}$ the constant such that $\Delta P=\frac{1}{K}\ln(Q)$.

Let's focus on the ask side. We can write 
\\[
    \begin{align}
        \lambda^a(\delta^a)&=\Lambda\mathbb{P}(\Delta P > \delta^a)\\\ 
        &= \Lambda\mathbb{P}(\ln(Q)>K\delta^a) \\\ 
        &= \Lambda\mathbb{P}(Q>e^{K\delta^a})\\\ 
        &=\alpha\Lambda e^{\alpha K\delta^a},
    \end{align}
\\]
where the last equality follows from an easy integration. We set $A=\frac{\Lambda}{\alpha}$ and $k=\alpha K$. Similarly for the bid side.

This result gives us a functional form for the intensity, and we will use the functional form and market data to estimate $A$ and $k$. 
To do so we follow the steps described in {% cite laruelle_parameter_estimation %}, {% cite kch_avellanda_stoikov %}anf {% cite naz_avellanda_stoikov %}.
As above, we focus only on the ask side.

- Pick a time $t_0$ and record the mid price at $t_0$, say $m(t_0)$.
- Look for the first time $\bar{t}(t_0)=\inf\{t\in[t_0, T]\ \vert\ \text{the order with price } P^a(t_0) \text{ is executed}\}$ 
  and record both $\bar{t}(t_0)$ and  $\delta^a(t_0)$. We added a maximum time limit, $T$,  to prevent the search from running forever
  We left the definition of the order being executed vague on purpose. As observed by Lehalle in {% cite kch_avellanda_stoikov %}, 
  there are some choices to make at this point, which depend on the fact that your order is not actually on the orderbook. 
  The first one is what to do if $P^a(t_0)$ is smaller than the actual best ask observed in the data. 
  The second one is about agreeing on the definition of the order being executed. Strictly speaking we need a market buy 
  order to fill our limit order, as it in general it is not enough for mid price to cross the order price (due to possible cancellations).
  The latter characterization of an order being executed is much easier to compute.
- Repeat the steps above for various initial times. Each choice provides a couple $(\delta^a(t_i), \bar{t}(t_i) - t_i)$. 
  We observe that for each  $\delta^a(t_i),$ we can have multiple values of  $\bar{t}(t_i) - t_i$. Let's call the set of 
  these inter-arrival times $\Gamma_{t_i}(\delta^a)$. Since we are assuming the elements of $\Gamma_{t_i}(\delta^a)$ to come 
  from a Poisson distribution with parameter $\lambda^a(\delta^a)$, we can estimate $\lambda^a(\delta^a)$ with the average 
  over $\Gamma(\delta^a)$. We denote the average by $\langle\Gamma_{t_i}(\delta^a)\rangle$
- Plot the points $\{(\delta^a(t_i), \langle\Gamma_{t_i}(\delta^a)\rangle)\}_{i\geq 0}$. The resulting chart should be similar to [] and [].
  To estimate $A$ and $k$ we consider two points