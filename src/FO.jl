using SymEngine
export FO,PFO,dag
export Up,Dn,Sl

abstract type AbstractFO end

"""
    Up spin
"""
abstract type Up end

"""
    Down spin
"""
abstract type Dn end

"""
    Spinless
"""
abstract type Sl end
const Spin = Union{Type{Up},Type{Sl},Type{Dn}}

"""
struct FO
    This package assume that each fermionic operator consist of such several parts.
    Example of Fermionic Operator: c_4_(up)^dagger
    1. Symbol. Example: c
    2. Site. Example: 4
    3. Spin. Example: up/dn
    4. Dag. Example: true/false
"""
struct FO <: AbstractFO
    symbol::Symbol
    site::Int
    spin::Spin
    dag::Bool
end

"""
struct PFO
    Powered Ferminoic Operators.
    An abstract FO wich indicate a FO with power.
    Each FO is binded with a abstract symbol to indicate its power.
"""
struct PFO <: AbstractFO
    fo::FO
    pow::Basic
end

export dag
dag(fo::FO) = FO(fo.symbol,fo.site,fo.spin,!(fo.dag))
dag(pfo::PFO) = PFO(dag(pfo.fo),pfo.pow)