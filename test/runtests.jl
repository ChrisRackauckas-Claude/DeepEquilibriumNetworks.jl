using SafeTestsets, Test, SciMLTesting

const GROUP = uppercase(get(ENV, "GROUP", "CPU"))

@info "Running tests for GROUP: $GROUP"

@time withenv("GROUP" => GROUP) do
    run_tests(;
        core = () -> begin
            @time @safetestset "Utils Tests" include("utils_tests.jl")
            @time @safetestset "Layers Tests" include("layers_tests.jl")
        end,
        qa = joinpath(@__DIR__, "qa_tests.jl"),
        default = "CPU",
    )
end
