"""
The gene-reaction rules (grr) are written as 
[[gene1 and gene2...] or [gene3 and...] ...]
so for a reaction to be available it is sufficient that one group
is available, but inside a group all of the genes need to be available
"""

@testset "knockout_single_gene" begin
    m = StandardModel()
    add!(m, Metabolite("A"))
    add!(m, Metabolite("B"))
    add!(m, Gene("g1"))
    add!(m, Gene("g2"))
    add!(m, Reaction("v1", metabolites = Dict("A" => -1.0, "B" => 1.0), grr = [["g1"]]))
    add!(
        m,
        Reaction("v2", metabolites = Dict("A" => -1.0, "B" => 1.0), grr = [["g1", "g2"]]),
    )
    add!(
        m,
        Reaction("v3", metabolites = Dict("A" => -1.0, "B" => 1.0), grr = [["g1"], ["g2"]]),
    )
    add!(
        m,
        Reaction(
            "v4",
            metabolites = Dict("A" => -1.0, "B" => 1.0),
            grr = [["g1", "g2"], ["g2"]],
        ),
    )

    rm!(Gene, m, "g1", knockout_reactions = true)

    @test length(m.reactions) == 2
    @test !haskey(m.reactions, "v1")
    @test !haskey(m.reactions, "v2")
end

@testset "knockout_multiple_genes" begin
    m = StandardModel()
    add!(m, Metabolite("A"))
    add!(m, Metabolite("B"))
    add!(m, Gene("g1"))
    add!(m, Gene("g2"))
    add!(m, Gene("g3"))
    add!(
        m,
        Reaction(
            "v1",
            metabolites = Dict("A" => -1.0, "B" => 1.0),
            grr = [["g1"], ["g2"], ["g3"]],
        ),
    )
    add!(
        m,
        Reaction("v2", metabolites = Dict("A" => 1.0, "B" => -1.0), grr = [["g1"], ["g3"]]),
    )
    rm!(Gene, m, ["g1", "g3"], knockout_reactions = true)

    @test haskey(m.reactions, "v1")
    @test !haskey(m.reactions, "v2")
end
