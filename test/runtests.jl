using Test,FermionicOperatorStringAnalyzer

@testset "FOSA.jl" begin
  @testset "$filename" for filename in [
    "FO.jl",
    "FOS.jl",
    "simplify.jl"
  ]
    println("Running $filename")
    include(filename)
  end
end