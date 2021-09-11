export FOKet,FOBra

abstract type AbstractVanisher end
abstract type AbstractKet <: AbstractVanisher end
abstract type AbstractBra <: AbstractVanisher end

struct FOKet <: AbstractKet
    vanish :: Array{FO,1}
end

struct FOBra <: AbstractBra
    vanish :: Array{FO,1}
end

"""
    function checkpair(bra::AbstractBra,ket::AbstractKet)

    bra and ket should be a pair, which means that: for arbitary Fermionic Operator(FO)
    if vanish(bra,op) then vanish(ket,dag(op)).

    We should check this because if we call the (function simplify) and moving a FO to the right. It would met its adjoint.
    If its adjoint could be vanished by bra, this met will only produce a coefficient and it is free to exit the moving procedure.

    <0|...(no d and d dag)... d d+ ....|0> = <0|...(no d and d dag)... ....|0>
"""
function checkpair(bra::FOBra,ket::FOKet)
    for i in bra.vanish
        if !(dag(i) in ket.vanish)
            return false
        end
    end
    return true
end

export vanish
vanish(bra::FOBra,fo::FO) = fo in bra.vanish
vanish(ket::FOKet,fo::FO) = fo in ket.vanish
vanish(bra::FOBra,pfo::PFO) = pfo.fo in bra.vanish
vanish(ket::FOKet,pfo::PFO) = pfo.fo in ket.vanish