using Reduce

# @testset "simplify 1D L=2 Spinless Nv = 1" begin
#     L = 4
#     fos = FOS()
    
#     for i = 1:L
#         push!(fos.fos,PFO(FO(:α,(i%L)+1,Sl,false),symbols(Meta.parse("b$(i)"))))
#         push!(fos.fos,PFO(FO(:β,i,Sl,false),symbols(Meta.parse("b$(i)"))))
#     end

#     for i = 1:L
#         push!(fos.fos,PFO(FO(:α,i,Sl,true),symbols(Meta.parse("i$(i)"))))
#         push!(fos.fos,PFO(FO(:σ,i,Sl,true),symbols(Meta.parse("s$(i)"))))
#         push!(fos.fos,PFO(FO(:β,i,Sl,true),symbols(Meta.parse("j$(i)"))))
#     end

#     bra = FOBra([[FO(:α,i,Sl,true) for i =1:L]...,[FO(:β,i,Sl,true) for i =1:L]...])
#     ket = FOKet([[FO(:α,i,Sl,false) for i =1:L]...,[FO(:β,i,Sl,false) for i =1:L]...])

#     (expr,redundant,delta) = simplify(fos,bra,ket)
#     display(expr)
#     print("\n")
#     display(redundant)
#     print("\n")
#     display(delta)
#     print("\n")
# end

# @testset "simplify 1D L=2 Spinless Nv = 2" begin
#     L = 4
#     fos = FOS()
    
#     for i = 1:L
#         push!(fos.fos,PFO(FO(:α1,(i%L)+1,Sl,false),symbols(Meta.parse("b$(i)n1"))))
#         push!(fos.fos,PFO(FO(:β1,i,Sl,false),symbols(Meta.parse("b$(i)n1"))))

#         push!(fos.fos,PFO(FO(:α2,(i%L)+1,Sl,false),symbols(Meta.parse("b$(i)n2"))))
#         push!(fos.fos,PFO(FO(:β2,i,Sl,false),symbols(Meta.parse("b$(i)n2"))))
#     end

#     for i = 1:L
#         push!(fos.fos,PFO(FO(:α1,i,Sl,true),symbols(Meta.parse("i$(i)1"))))
#         push!(fos.fos,PFO(FO(:α2,i,Sl,true),symbols(Meta.parse("i$(i)2"))))
#         push!(fos.fos,PFO(FO(:σ,i,Sl,true),symbols(Meta.parse("s$(i)"))))
#         push!(fos.fos,PFO(FO(:β1,i,Sl,true),symbols(Meta.parse("j$(i)1"))))
#         push!(fos.fos,PFO(FO(:β2,i,Sl,true),symbols(Meta.parse("j$(i)2"))))
#     end

#     bra = FOBra([[FO(Meta.parse("$(s)$(nv)"),i,Sl,true) for i =1:L for s in ["α";"β"] for nv = 1:2]...])
#     ket = FOKet([[FO(Meta.parse("$(s)$(nv)"),i,Sl,false) for i =1:L for s in ["α";"β"] for nv = 1:2]...])

#     (expr,redundant,delta) = simplify(fos,bra,ket)
#     display(expr)
#     print("\n")
#     display(redundant)
#     print("\n")
#     display(delta)
#     print("\n")
# end

# @testset  "simplify 2D Lx,Ly = arbitary; Spinless; Nv = arbitary" begin
#     Lx,Ly = 2,2
#     Nv = 2
#     fos = FOS()

#     for nv = 1:Nv
#         for dir = ["r";"d"]
#             for iy = 1:Ly
#                 for ix = 1:Lx
#                     if dir == "r"
#                         ox,oy = (ix%Lx)+1,iy
#                         si,so = iy+Ly*(ix-1),oy+Ly*(ox-1)
#                         push!(fos.fos,PFO(FO(Meta.parse("l$(nv)"),si,Sl,false),symbols(Meta.parse("b$(si)_$(so)nv$(nv)"))))
#                         push!(fos.fos,PFO(FO(Meta.parse("r$(nv)"),so,Sl,false),symbols(Meta.parse("b$(si)_$(so)nv$(nv)"))))
#                     else
#                         ox,oy = ix,(iy%Ly)+1
#                         si,so = iy+Ly*(ix-1),oy+Ly*(ox-1)
#                         push!(fos.fos,PFO(FO(Meta.parse("u$(nv)"),si,Sl,false),symbols(Meta.parse("b$(si)_$(so)nv$(nv)"))))
#                         push!(fos.fos,PFO(FO(Meta.parse("d$(nv)"),so,Sl,false),symbols(Meta.parse("b$(si)_$(so)nv$(nv)"))))
#                     end
#                 end
#             end
#         end
#     end

#     for lx = 1:Lx
#         for ly = 1:Ly
#             site = ly+Ly*(lx-1)
#             for dir in ["l";"u";"r";"d"]
#                 for nv = 1:Nv
#                     push!(fos.fos,PFO(FO(Meta.parse("$(dir)$(nv)"),site,Sl,true),symbols(Meta.parse("$(dir)$(site)nv$(nv)"))))
#                 end
#             end
#             push!(fos.fos,PFO(FO(:σ,site,Sl,true),symbols(Meta.parse("s$(site)"))))
#         end
#     end

#     bra = FOBra([[FO(Meta.parse("$(s)$(nv)"),i,Sl,true) for i =1:Lx*Ly for s in ["l";"r";"d";"u"] for nv = 1:Nv]...])
#     ket = FOKet([[FO(Meta.parse("$(s)$(nv)"),i,Sl,false) for i =1:Lx*Ly for s in ["l";"r";"d";"u"] for nv = 1:Nv]...])

#     (expr,redundant,delta) = simplify(fos,bra,ket)
#     display(Reduce.Algebra.factor(expr))
#     print("\n")
#     display(redundant)
#     print("\n")
#     display(delta)
#     print("\n")
# end

@testset  "simplify 2D Lx,Ly = arbitary; Spinless; Nv = 1" begin
    Lx,Ly = 2,2
    fos = FOS()

    for dir = ["r";"d"]
        for ix = 1:Lx
            for iy = 1:Ly
                if dir == "r"
                    ox,oy = (ix%Lx)+1,iy
                    si,so = iy+Ly*(ix-1),oy+Ly*(ox-1)
                    push!(fos.fos,PFO(FO(Meta.parse("r"),si,Sl,false),symbols(Meta.parse("b$(si)$(so)"))))
                    push!(fos.fos,PFO(FO(Meta.parse("l"),so,Sl,false),symbols(Meta.parse("b$(si)$(so)"))))
                else
                    ox,oy = ix,(iy%Ly)+1
                    si,so = iy+Ly*(ix-1),oy+Ly*(ox-1)
                    push!(fos.fos,PFO(FO(Meta.parse("u"),so,Sl,false),symbols(Meta.parse("b$(si)$(so)"))))
                    push!(fos.fos,PFO(FO(Meta.parse("d"),si,Sl,false),symbols(Meta.parse("b$(si)$(so)"))))
                end
            end
        end 
    end

    for ix = 1:1:Lx
        for iy = 1:1:Ly
            site = iy+Ly*(ix-1)
            for dir in ["l";"u";"r";"d"]
                push!(fos.fos,PFO(FO(Meta.parse("$(dir)"),site,Sl,true),symbols(Meta.parse("$(dir)$(site)"))))
            end
            push!(fos.fos,PFO(FO(:σ,site,Sl,true),symbols(Meta.parse("S$(site)"))))
            
            # push!(fos.fos,PFO(FO(:σ,site,Up,true),symbols(Meta.parse("Sup$(site)"))))
            # push!(fos.fos,PFO(FO(:σ,site,Dn,true),symbols(Meta.parse("Sdn$(site)"))))
        end
    end

    bra = FOBra([[FO(Meta.parse("$(s)"),i,Sl,true) for i =1:Lx*Ly for s in ["l";"r";"d";"u"]]...])
    ket = FOKet([[FO(Meta.parse("$(s)"),i,Sl,false) for i =1:Lx*Ly for s in ["l";"r";"d";"u"]]...])


    display(fos)
    (expr,redundant,delta) = simplify(fos,bra,ket)
    display(Reduce.Algebra.factor(expr))
    print("\n")
    display(redundant)
    print("\n")
    display(delta)
    print("\n")
end



# @testset  "simplify 2D Lx,Ly = 2,2; Spinless; Nv = 1; OBC" begin
#     Lx,Ly = 2,2
#     fos = FOS()

#     si,so = (1,3)
#     push!(fos.fos,PFO(FO(Meta.parse("r"),si,Sl,false),symbols(Meta.parse("b$(si)$(so)"))))
#     push!(fos.fos,PFO(FO(Meta.parse("l"),so,Sl,false),symbols(Meta.parse("b$(si)$(so)"))))
    
#     si,so = (2,4)
#     push!(fos.fos,PFO(FO(Meta.parse("r"),si,Sl,false),symbols(Meta.parse("b$(si)$(so)"))))
#     push!(fos.fos,PFO(FO(Meta.parse("l"),so,Sl,false),symbols(Meta.parse("b$(si)$(so)"))))
    
#     si,so = (1,2)
#     push!(fos.fos,PFO(FO(Meta.parse("d"),si,Sl,false),symbols(Meta.parse("b$(si)$(so)"))))
#     push!(fos.fos,PFO(FO(Meta.parse("u"),so,Sl,false),symbols(Meta.parse("b$(si)$(so)"))))
    
#     si,so = (3,4)
#     push!(fos.fos,PFO(FO(Meta.parse("d"),si,Sl,false),symbols(Meta.parse("b$(si)$(so)"))))
#     push!(fos.fos,PFO(FO(Meta.parse("u"),so,Sl,false),symbols(Meta.parse("b$(si)$(so)"))))
    
    
#     push!(fos.fos,PFO(FO(:σ,2,Sl,true),:s2))
#     push!(fos.fos,PFO(FO(:r,2,Sl,true),:r2))
#     push!(fos.fos,PFO(FO(:u,2,Sl,true),:u2))

#     push!(fos.fos,PFO(FO(:d,1,Sl,true),:d1))
#     push!(fos.fos,PFO(FO(:σ,1,Sl,true),:s1))
#     push!(fos.fos,PFO(FO(:r,1,Sl,true),:r1))

#     push!(fos.fos,PFO(FO(:l,3,Sl,true),:l3))
#     push!(fos.fos,PFO(FO(:d,3,Sl,true),:d3))
#     push!(fos.fos,PFO(FO(:σ,3,Sl,true),:s3))

#     push!(fos.fos,PFO(FO(:u,4,Sl,true),:u4))
#     push!(fos.fos,PFO(FO(:l,4,Sl,true),:l4))
#     push!(fos.fos,PFO(FO(:σ,4,Sl,true),:s4))

#     bra = FOBra([[FO(Meta.parse("$(s)"),i,Sl,true) for i =1:Lx*Ly for s in ["l";"r";"d";"u"]]...])
#     ket = FOKet([[FO(Meta.parse("$(s)"),i,Sl,false) for i =1:Lx*Ly for s in ["l";"r";"d";"u"]]...])


#     display(fos)
#     (expr,redundant,delta) = simplify(fos,bra,ket)
#     display(Reduce.Algebra.factor(expr))
#     print("\n")
#     display(redundant)
#     print("\n")
#     display(delta)
#     print("\n")
# end