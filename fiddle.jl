include("./src/CompGraph.jl")

using .CompGraph

a, b = CompGraph.variables(2)
println(a * b / a)
