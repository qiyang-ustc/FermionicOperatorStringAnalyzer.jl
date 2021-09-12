@testset "simplify 1D L=2 Spinless Nv = 1" begin
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
    print("\n")
    display(redundant)
    print("\n")
    display(delta)
    print("\n")
end

@testset "simplify 1D L=2 Spinless Nv = 2" begin
    L = 4
    fos = FOS()
    
    for i = 1:L
        push!(fos.fos,PFO(FO(:α1,(i%L)+1,Sl,false),symbols(Meta.parse("b$(i)n1"))))
        push!(fos.fos,PFO(FO(:β1,i,Sl,false),symbols(Meta.parse("b$(i)n1"))))

        push!(fos.fos,PFO(FO(:α2,(i%L)+1,Sl,false),symbols(Meta.parse("b$(i)n2"))))
        push!(fos.fos,PFO(FO(:β2,i,Sl,false),symbols(Meta.parse("b$(i)n2"))))
    end

    for i = 1:L
        push!(fos.fos,PFO(FO(:α1,i,Sl,true),symbols(Meta.parse("i$(i)1"))))
        push!(fos.fos,PFO(FO(:α2,i,Sl,true),symbols(Meta.parse("i$(i)2"))))
        push!(fos.fos,PFO(FO(:σ,i,Sl,true),symbols(Meta.parse("s$(i)"))))
        push!(fos.fos,PFO(FO(:β1,i,Sl,true),symbols(Meta.parse("j$(i)1"))))
        push!(fos.fos,PFO(FO(:β2,i,Sl,true),symbols(Meta.parse("j$(i)2"))))
    end

    bra = FOBra([[FO(Meta.parse("$(s)$(nv)"),i,Sl,true) for i =1:L for s in ["α";"β"] for nv = 1:2]...])
    ket = FOKet([[FO(Meta.parse("$(s)$(nv)"),i,Sl,false) for i =1:L for s in ["α";"β"] for nv = 1:2]...])

    (expr,redundant,delta) = simplify(fos,bra,ket)
    display(expr)
    print("\n")
    display(redundant)
    print("\n")
    display(delta)
    print("\n")
end