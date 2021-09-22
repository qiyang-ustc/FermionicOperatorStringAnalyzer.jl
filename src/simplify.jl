export simplify
using Reduce
"""
    function simplify(FOS::AbstractFOS,Bra::AbstractBRA,Ket::AbstractBRA)
"""
function simplify(fos::AbstractFOS,bra::AbstractBra,ket::AbstractKet)
    checkpair(bra,ket)
    redundant = []
    coef = Basic(0) # suitable for dispatch
    delta = []

    pow_list = [fos[i].pow for i=1:length(fos)]
    while length(fos)!=0
        if vanish(bra,first(fos))
            absorb!(delta,fos)
        elseif vanish(ket,first(fos))
            coef = move_right!(coef,delta,fos)
        else
            extract_redundant!(fos,redundant)
        end
    end

    for (pow1,pow2) in delta
        coef = subs(coef, pow2=>pow1)
    end
    for pow in pow_list
        coef = subs(coef, pow^2=>pow)
    end
    for pow in pow_list
        coef = subs(coef, 2*pow=>0)
    end
    expr = SymEngine.toString(coef)

    # This is a foolish implementation, the aim is eliminating even term in expr

# Such is an option (guildline?) to develop this foolish implementation
# =================================
#   using Metatheory
#   using Metatheory.Library
#   using Metatheory.EGraphs

#   my_t = @theory begin
#       x * x => x
#       ex + ex => 0
#   end
#   t_add = commutative_group(:+, 0, :-)
#   t_mul = commutative_monoid(:*, 1)
#   t = my_t ∪ t_add ∪ t_mul

#   ex = :(b1*b1+b1*b2+b1*b2+b1*i1+b1*s1+b1*j1+b1*b2+b1*b2+b1*i1+b1*s1+b2*b2+b2*s1+b2*s2)

#   g = EGraph(ex)
#   saturate!(g, t)
#   ex = extract!(g, astsize)
#   # :(s2 * b2 + (s1 * b2 + (b2 + (b1 + j1 * b1))))
# =================================

    tol = 100
    for i = 2:2:tol
        expr = replace(expr,"+ $i*"=>"+ 0*")
        expr = replace(expr,"+ $(i+1)*"=>"+ 1*")
    end
    expr = RExpr(expr)
    # ---- Foolish part ends

    return (expr,redundant,delta) # +0 keeps the -1^0 safe.
end

"""
    function extract!(fos::AbstractFOS,redundant::Array)
        return nothing
    
    Extract the operator at the left/first of Input fos into result. Because it can not be vanished by Bra and Ket
"""
function extract_redundant!(fos::AbstractFOS,redundant::Array)
    push!(redundant,first(fos.fos))
    popfirst!(fos.fos)
end

"""
    Absorb the left Operator in fos into Bra. Will produce a coefficient into result.
"""
function absorb!(delta::Array,fos::AbstractFOS)
    @warn "delta function looks like delta(n,0) is produced because the operator"
    # TODO: implement this function
end

"""
    function move_right!(coef::Dict,fos::AbstractFOS)
"""
function move_right!(coef::Basic,delta::Array,fos::AbstractFOS)
    for i = 2:length(fos.fos)
        if fos[i].fo == dag(fos[1].fo)
            push!(delta,(fos[1].pow,fos[i].pow))
            deleteat!(fos.fos,i)
            deleteat!(fos.fos,1)
            return coef
        else
            coef = coef+fos[1].pow*fos[i].pow
        end
    end
    @warn "Symbol $(fos[1]) doesnot meet a pair!"
end