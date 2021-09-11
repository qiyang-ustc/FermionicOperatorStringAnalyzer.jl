@testset "FOS Constructor" begin 
    fo1 = PFO(FO(:c,2,Up,false),:t1)
    fo2 = PFO(FO(:c,-1,Dn,true),:t2)
    fos = FOS([fo1;fo2])
    @test isa(fos,FOS)
end


