using Pkg
Pkg.activate("$(@__DIR__)/..")

include("./Functions.jl")
include("./Model.jl")

nn = NeuralNetwork([NeuronLayer(27, 3, sigmoid)])
println(process(nn, transpose(Float64[i for i in 1:27])))
