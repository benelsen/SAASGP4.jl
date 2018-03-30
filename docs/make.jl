using Documenter, SAASGP4

makedocs(
    format = :html,
    sitename = "SAASGP4.jl",
    modules = [SAASGP4],
    pages = [
        "Home" => "index.md",
        "Manual" => Any[
            "Guide" => "guide.md",
        ],
        "Library" => Any[
            "Public" => "lib.md",
        ],
    ],
)

deploydocs(
    repo = "github.com/benelsen/SAASGP4.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
    julia = "0.6",
)
