# FermionicOperatorStringAnalyzer.jl

A ToolKit to analyze by transforming a set of Fermionic Operators to a standard form.

## Introduction

A brief example in "./test/simplify.jl".

First we have:

$$ \langle 0|_{lrud}(r_{1}^{b13}) (l_{3}^{b13}) (r_{2}^{b24}) (l_{4}^{b24}) (r_{3}^{b31}) (l_{1}^{b31}) (r_{4}^{b42}) (l_{2}^{b42}) (u_{2}^{b12}) (d_{1}^{b12}) (u_{1}^{b21}) (d_{2}^{b21}) (u_{4}^{b34}) (d_{3}^{b34}) (u_{3}^{b43}) (d_{4}^{b43}) (l_{1}^{l1})^{\dagger} (u_{1}^{u1})^{\dagger} (r_{1}^{r1})^{\dagger} (d_{1}^{d1})^{\dagger} (σ_{1}^{S1})^{\dagger} (l_{2}^{l2})^{\dagger} (u_{2}^{u2})^{\dagger} (r_{2}^{r2})^{\dagger} (d_{2}^{d2})^{\dagger} (σ_{2}^{S2})^{\dagger} (l_{3}^{l3})^{\dagger} (u_{3}^{u3})^{\dagger} (r_{3}^{r3})^{\dagger} (d_{3}^{d3})^{\dagger} (σ_{3}^{S3})^{\dagger} (l_{4}^{l4})^{\dagger} (u_{4}^{u4})^{\dagger} (r_{4}^{r4})^{\dagger} (d_{4}^{d4})^{\dagger} (σ_{4}^{S4})^{\dagger}|0\rangle_{lurd\sigma} $$

This program tell you it is equal to

$$(-1)^s|\sigma_1\sigma_2\sigma_3\sigma_4\rangle$$

while

$$s = (s3 + 1)*b43 + b34*s3 + (b42 + s1)*b12 + (s2 + s3 + b43)*b42 + (s1 + 1 + b42 + b24)*b21 + (s1 + s2 + b43 + b42)*b31 + (s3 + 1 + s2 + b43 + b34 + b31)*b24 + (s2 + 1 + s1 + b42 + b24 + b21)*b13 $$
