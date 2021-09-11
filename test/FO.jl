@testset "FO Constructor" begin 
    fo = FO(:c,2,Up,false)
    @test isa(fo,FO)
    fo = FO(:c,-1,Dn,true)
    @test isa(fo,FO)
end

@testset "PFO Constructor" begin 
    fo = FO(:c,2,Up,false)
    pfo = PFO(fo,:n1)
    @test isa(pfo,PFO)
    fo = FO(:d,-2,Sl,true)
    pfo = PFO(fo,:n3)
    @test isa(pfo,PFO)
end

