export simplify
using Metatheory
using Metatheory.EGraphs
@metatheory_init
"""
    function simplify(FOS::AbstractFOS,Bra::AbstractBRA,Ket::AbstractBRA)
"""
function simplify(fos::AbstractFOS,bra::AbstractBra,ket::AbstractKet)
    checkpair(bra,ket)
    redundant = []
    coef = ""
    delta = []
    while length(fos)!=0
        if vanish(bra,first(fos))
            absorb!(delta,fos)
        elseif vanish(ket,first(fos))
            coef = move_right!(coef,delta,fos)
        else
            extract_redundant!(fos,redundant)
        end
    end
    
    expr = Meta.parse(coef*"0")
    comm_group = @theory begin
        a + b => b + a
        a + a => 0 # mod 2 (Z2)
        a + 0 => a
        a + (b + c) => (a + b) + c
    end
    comm_monoid = @theory begin
        # commutativity
        a * b => b * a
        # identity
        a * 1 => a
        # associativity
        a * (b * c) => (a * b) * c
        (a * b) * c => a * (b * c)
    end
    rule = union(comm_group,comm_monoid)
    
    @show expr
    g = EGraph(expr)
    saturate!(g,rule)
    output_ex = extract!(g,astsize)

    return (output_ex,redundant,delta) # +0 keeps the -1^0 safe.
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
function move_right!(coef::String,delta::Array,fos::AbstractFOS)
    for i = 2:length(fos.fos)
        if fos[i].fo == dag(fos[1].fo)
            push!(delta,(fos[1].pow,fos[i].pow))
            deleteat!(fos.fos,i)
            deleteat!(fos.fos,1)
            return coef
        else
            coef = coef*"$(fos[1].pow)*$(fos[i].pow)+"
        end
    end
    @warn "Symbol $(fos[1]) doesnot meet a pair!"
end