@testset "simplify 1D L=2 Spinless" begin
    L = 2
    fos = FOS()
    
    for i = 1:L
        push!(fos.fos,PFO(FO(:α,(i%L)+1,Sl,false),Symbol("b$(i)")))
        push!(fos.fos,PFO(FO(:β,i,Sl,false),Symbol("b$(i)")))
    end

    for i = 1:L
        push!(fos.fos,PFO(FO(:α,i,Sl,true),Symbol("i$(i)")))
        push!(fos.fos,PFO(FO(:σ,i,Sl,true),Symbol("σ$(i)")))
        push!(fos.fos,PFO(FO(:β,i,Sl,true),Symbol("j$(i)")))
    end

    bra = FOBra([[FO(:α,i,Sl,true) for i =1:L]...,[FO(:β,i,Sl,true) for i =1:L]...])
    ket = FOKet([[FO(:α,i,Sl,false) for i =1:L]...,[FO(:β,i,Sl,false) for i =1:L]...])

    @show simplify(fos,bra,ket)
end