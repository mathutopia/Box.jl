using Box
using Test

@testset "Box.jl" begin
    # Write your tests here.
    @test is_pluto_file(@__FILE__)==false
    @test is_pluto_file("E:\\DevPkgs\\dplusbook\\04clustering/1distance.jl") == true

end
