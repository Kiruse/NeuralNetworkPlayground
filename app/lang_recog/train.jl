using Pkg
Pkg.activate("$(@__DIR__)/..")

include("./Functions.jl")
include("./Model.jl")

#nn = NeuralNetwork([NeuronLayer(20, )])
