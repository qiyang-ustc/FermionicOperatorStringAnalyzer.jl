export FOS,first,last,getindex,setindex!
abstract type AbstractFOS end
"""
    Fermionic Operators String is a String of Fermionic Operator with a series undetermined employed number.
"""
struct FOS <: AbstractFOS    
    fos::Array{PFO,1}
end

FOS() = FOS([])

import Base.first,Base.last,Base.getindex,Base.setindex!,Base.length
first(fos::FOS) = first(fos.fos)
last(fos::FOS) = last(fos.fos)
getindex(fos::FOS,key...) = getindex(fos.fos,key...)
setindex!(fos::FOS,value,key...) = setindex!(fos.fos,value,key...)
length(fos::FOS) = length(fos.fos)

import Base.display
export display
function display(fos::FOS)
    fos = fos.fos
    s = ""
    for i=1:length(fos)
        fo = fos[i].fo
        dag = fo.dag ? "^{\\dagger}" : ""
        s=s*"($(fo.symbol)_{$(fo.site)}^{$(fos[i].pow)})"*dag*" "
    end
    display(s)
end