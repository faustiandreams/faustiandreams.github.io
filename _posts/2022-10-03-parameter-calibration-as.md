---
layout: post
tags: market_making paper_explained
mathjax: true
excerpt: Calibration procedure for $\Lambda$ and $k$ in the AS model
title: "Parameter calibration in Avellaneda-Stoikov"
---

The Avellaneda-Stoikov (AS for short) model for market making is a classical example of how to approach market making
as a stochastic control problem. We will assume familiarity with the framework and 
focus on estimating the parameters discussed in section "2.5" of {% cite avellaneda_stoikov_mm_model %}.

In AS it is assumed that execution of limit orders follows a Poisson distribution with intensities $\lambda^a$ for the ask side and $\lambda^b$ for the bid side. Since orders further away from the best quotes have a lower chance of being executed the intensities are a function of the depth of the limit order. More formally, if $P^a$ is the ask price of the order and $m$ is the mid-price, we set $\delta^a=P^a-m$ and reformulate the previous sentence saying that $\lambda^a$ depends on $\delta^a$, i.e. $\lambda^a=\lambda^a(\delta^a)$. Similarly for the bid side. We are interested in estimating the intensities from the data. 

The reasoning in the paper follows from several empirical results about price impact and order density, and it goes as follows:

> It has been empirically verified that price impact as a function of order size behaves in the following way
> \\[\Delta P\approx\ln(Q),\\]
> with $Q$ order size. Thus, if we know the distribution of the order sizes, we can link the incoming orders to the probability of being executed at some depth $\lambda^a(\delta^a)$.
> Following the paper we use the following density for the size of the incoming orders
> \\[f^Q(x)\approx x^{-1-\alpha}.\\]

Let's put these two facts together. For simplicity (following the paper) we assume a constant frequency $\Lambda$ of buy or sell orders
We also call $\frac{1}{K}$ the constant such that $\Delta P=\frac{1}{K}\ln(Q)$.

Let's focus on the ask side. We can write 
\\[
    \begin{align}
        \lambda^a(\delta^a)&=\Lambda\mathbb{P}(\Delta P > \delta^a)\\\ 
        &= \Lambda\mathbb{P}(\ln(Q)>K\delta^a) \\\ 
        &= \Lambda\mathbb{P}(Q>e^{K\delta^a})\\\ 
        &= \Lambda\int_{e^{K\delta^a}}^{\infty}x^{-1-\alpha}dx\\\ 
        &= -\frac{\Lambda}{\alpha} \left( x^{-\alpha}\right)\vert^{\infty}_{e^{K\delta^a}}\\\ 
        &= A e^{-k\delta^a}, \label{a}\tag{1}
    \end{align}
\\]
where the last equality follows from an easy integration. We set $A=\frac{\Lambda}{\alpha}$ and $k=\alpha K$. Similarly for the bid side.

Thus, in this paper, the intensity has a simple functional form with two parameters $A$ and $k$ to be estimated from historical data.
The idea then is the following: Estimate both parameters (which are constant), and then use them to get the intensity
when running the market making algorithm.  
As described in {% cite laruelle_parameter_estimation %}, {% cite kch_avellaneda_stoikov %} and {% cite naz_avellaneda_stoikov %},
there are a few ways to calibrate the parameters.
The idea is to generate points in the $\delta\lambda$-plane using historical data, and fit the parameters 
to these points. 
We focus only on the ask side and avoid writing the upper index for simplicity.  

<h3>
    Generating $(\delta, \lambda)$ couples
</h3>
- Fix $\delta_i > 0$ and a sequence of timestamps $t_0, \dots, t_n$ and a threshold $T > 0$.
- For each timestamp $t_j$ record the mid-price at $t_j$ say $m(t_j)$.
- We want $\bar{t}(\delta_i, t_j)=\inf\\{t\in[t_j, T]\ \vert\ \text{the order with price } m(t_j) + \delta_i \text{ is executed}\\}$. As observed by Lehalle in {% cite kch_avellaneda_stoikov %}
  we need to define what "being executed" means, and deal with some subtleties that can negatively affect the estimate of being executed.
  - We need to decide how to handle the case where $m(t_j) + \delta_i < \text{best ask}$, where $\text{best ask}$ comes from the actual data.
  - We can consider the order executed when there is a market order with price larger than the current limit order.
    Alternatively, if this data is not available, we can consider the order executed if we observe the mid-price above the order price.
- From the previous step, we end up with a set or arrival times $\Gamma(\delta_i)=\\{\bar{t}(\delta_i, t_j) - t_j), j=1,\dots,n\\}$.
  The Poisson assumption implies the execution times $\bar{t}(\delta_i, t_j)-t_j$ for a fixed $\delta_j$ 
  follow an exponential distribution with mean $\frac{1}{\lambda_i}$, where $\lambda_i = {\lambda(\delta_i)}$. 
  We first compute the average execution time for this depth: 
  ${\langle\Gamma(\delta_i)\rangle}=\frac{1}{n}\sum_{j=1}^n \bar{t}(\delta_i, t_j)-t_j$. The estimate for the intensity 
  at depth $\delta_i$ is then the reciprocal of this average time: $λ_i=\frac{1}{\langle\Gamma_(\delta_i)\rangle}$.

<h3>
    Fitting methods
</h3>

We can fit the points generated in the previous section using a few different methods.  
- Take the logarithm of both sides of $\lambda(\delta) = A e^{-k\delta}$ and fit a linear regression to it.
- Consider $(\delta_1, \lambda_1)$ and $(\delta_2, \lambda_2)$ obtained from the procedure in the previous paragraph, with $\delta_1 > \delta_2$.
  Both couples satisfy the equation above, from which it is easy to get 
  \\[\begin{cases}&k= \frac{1}{\delta_1 - \delta_2}\log\left(\frac{\lambda_1}{\lambda_2}\right)\\\ \\\ &A=\lambda_1 e^{k\delta_1}\end{cases}.\\]

The second method is more sensitive to outliers and noise in the generation process, as it depends only on two points.

<br>  

## References
{% bibliography --cited %}
