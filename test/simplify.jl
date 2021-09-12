@testset "simplify 1D L=2 Spinless" begin
    L = 4
    fos = FOS()
    
    for i = 1:L
        push!(fos.fos,PFO(FO(:α,(i%L)+1,Sl,false),symbols(Meta.parse("b$(i)"))))
        push!(fos.fos,PFO(FO(:β,i,Sl,false),symbols(Meta.parse("b$(i)"))))
    end

    for i = 1:L
        push!(fos.fos,PFO(FO(:α,i,Sl,true),symbols(Meta.parse("i$(i)"))))
        push!(fos.fos,PFO(FO(:σ,i,Sl,true),symbols(Meta.parse("s$(i)"))))
        push!(fos.fos,PFO(FO(:β,i,Sl,true),symbols(Meta.parse("j$(i)"))))
    end

    bra = FOBra([[FO(:α,i,Sl,true) for i =1:L]...,[FO(:β,i,Sl,true) for i =1:L]...])
    ket = FOKet([[FO(:α,i,Sl,false) for i =1:L]...,[FO(:β,i,Sl,false) for i =1:L]...])

    (expr,redundant,delta) = simplify(fos,bra,ket)
    display(expr)
    display(redundant)
    display(delta)
end