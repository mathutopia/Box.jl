using Box
using Documenter

DocMeta.setdocmeta!(Box, :DocTestSetup, :(using Box); recursive=true)

makedocs(;
    modules=[Box],
    authors="mathutopia <mathutopia@163.com> and contributors",
    sitename="Box.jl",
    format=Documenter.HTML(;
        canonical="https://mathutopia.github.io/Box.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/mathutopia/Box.jl",
    devbranch="main",
)
