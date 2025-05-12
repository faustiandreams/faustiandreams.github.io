---
layout: post
mathjax: true
tags: defi amm
excerpt: AMM design for efficient stablecoin swaps
title: "Stableswap pricing mechanism"
---

Curve is a defi exchange that in {% cite curve_original_paper %} introduced a novel mechanism for efficient stablecoin swap,
called Stableswap (also referred to as Curve V1).
The reason behind the success of Curve for stablecoin swaps is that Stableswap has drastically lower slippage than competitors.  
In this article we look into the key concepts and math behind this pricing mechanism.

<br>  

<h2>
    Notation and concepts
</h2>
Given $N$ stablecoins, let $x_j$ be the amount of the $j-th$ stablecoin in the pool. We use the following notation
$\boldsymbol{x}=(x_1, \dots, x_N)$.

The **equilibrium point** of the pool is defined as the vector $\hat{\boldsymbol{x}} = (\hat{x_1}, \dots, \hat{x_N})$ s.t. each entry has the
same dollar value. For stablecoins, when all of them are pegged, the equilibrium point is a vector with equal entries.  

We define the total number of assets in the pool at equilibrium as $\hat{D}:=\hat{x_1}+\dots, +\hat{x_N} = N\cdot \hat{x_1}$.
We call the vector $(\hat{x_1}, \dots, \hat{x_N}, \hat{D})$ **equilibrium configuration**. We point out
that $\boldsymbol{x}$ and $D$ have different roles, and it is common to
think of $D$ as derived from $\hat{\boldsymbol{x}}$.  
Usually $D$ is used as a proxy for the liquidity in the pool. In the equilibrium case described above, $D$ is the 
total dollar value of the pool (assuming no depegs).


We introduce the constant product invariant function and the constant sum invariant function. 
They are both functions of the assets in the pool and some parameters.  

The concept of invariant function is useful because the set of its zeros 
defines a curve (hypersurface), which represents the set of admissible 
configurations for that pool (both for the reserves and the parameters). 
Interactions with the pool change the value of the reserves or parameters. The new state of the pool after the interaction
**must** be an admissible configuration.  
Invariant functions are also called bonding curves in the literature, because for a pool with two assets they define curves. 



The **constant product invariant** is 
\\[I_P(x_1,\dots x_N, D):= \left(\prod_{i=1}^N x_i\right) - \left(\frac{D}{N}\right)^N.\\]
This invariant is used in liquidity pools like Uniswap V2. It has the property of being defined in the whole positive
hyperspace (all $x_i$ positive). The slippage associated with a swap can be quite large (especially for stablecoins).

The **constant sum invariant** is 
\\[I_S(x_1,\dots x_N, D):= \left(\sum_{i=1}^N x_i\right) - D.\\]
This invariant has no slippage, but it is not defined on the whole positive hyperspace. The reason is that
this invariant defines a hyperplane, which intersects the coordinate axis. The meaning of the intersection points,
$x_i=0$, is that the asset is completely depleted from the pool. We want to avoid this property, as the main goal here
is to provide liquidity and allow two sided trading.  

We observe that $(\hat{x_1}, \dots, \hat{x_N}, \hat{D})$ makes both functions $0$, meaning this point is an 
admissible configuration for both pools simultaneously. Moreover, this is the only point with such property.  

We define the **dynamic amplification factor** 
\\[\psi(x_1,\dots x_N, D; A):= A \cdot \left(\frac{D}{N}\right)^{-N} \left(\prod_{i=1}^N x_i\right), \\]
where $A$ is a positive constant set by the protocol.  
If we plug the equilibrium configuration in this function, we get $\psi(\hat{x_1},\dots \hat{x_N}, \hat{D}; A)= A$  
We call A the static amplification factor; its role in controlling the curve's shape is discussed below

<h2>
    Curve V1 invariant
</h2>
We define Curve invariant function by using $\psi$ to interpolate 
between the constant sum invariant and the constant product invariant.
We define
\\[\boxed{I(x_1,\dots x_N, D; A):= D^{N-1}\cdot \psi(x_1,\dots x_N, D; A)\cdot I_S(x_1,\dots x_N, D) + I_P(x_1,\dots x_N, D)}\\]
We make the following remarks
- Trivially, the equilibrium configuration is admissible for this invariant. 
- This formulation is mathematically equivalent to the formula presented in the original paper.
- For $\psi\rightarrow 0$ we have $I\rightarrow I_P$. For $\psi\rightarrow \infty$ we have $I\rightarrow I_S$.
- The original paper mentions that a large $A$ looks like Uniswap with
leverage. While this might be a useful way to think about it, the role of $A$ is to amplify the impact of the constant 
sum portion of the formula. More weight on the constant sum part means less slippage.
- We already mentioned that $\psi = A $ on the equilibrium configuration. With a bit more work it is possible to show
that outside of the equilibrium configuration $\psi<A$ (AM-GM inequality). So we get the maximum amplification effect (minimum slippage)
when the pool is balanced. This can be thought of as "liquidity is more concentrated around the equilibrium point".

<h2>
    Swaps
</h2>
In this section, wlog, we assume $N=2$, to focus on the mechanics of a swap between two tokens.
Say we want to sell $\Delta x_1$ of asset 1 to the pool. The pool computes the amount $\Delta x_2$ it needs to return 
us to perform the swap. We ignore fees.  

To compute $\Delta x_2$ we use the invariant formula twice:
- First, given $x_1$, $x_2$, and setting the curve invariant to $0$ it is possible to solve for the current value of $D$.
It is not possible to get an algebraic formulation for $D$, but the equation can be solved the equation numerically.
The liquidity pool uses Newton's method and clever re-writing to save on gas fees when solving numerically onchain.
- Now that $D$ is available the pool assumes $D$ stays constant _during the swap_. This is similar to how the liquidity
parameter does not change on Uniswap V2 during a swap. $D$ and $x_1+\Delta x_1$ are plugged in the invariant equation 
which solved with respect to $x_2$ this time (again, numerically).

<br>  

## References
{% bibliography --cited %}





