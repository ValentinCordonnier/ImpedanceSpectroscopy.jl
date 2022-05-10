using ImpedanceSpectroscopy
using Documenter

DocMeta.setdocmeta!(ImpedanceSpectroscopy, :DocTestSetup, :(using ImpedanceSpectroscopy); recursive=true)

makedocs(;
    modules=[ImpedanceSpectroscopy],
    authors="Valentin Cordonnier",
    repo="https://github.com/Valeuhhh/ImpedanceSpectroscopy.jl/blob/{commit}{path}#{line}",
    sitename="ImpedanceSpectroscopy.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Valeuhhh.github.io/ImpedanceSpectroscopy.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Valeuhhh/ImpedanceSpectroscopy.jl",
    devbranch="main",
)
