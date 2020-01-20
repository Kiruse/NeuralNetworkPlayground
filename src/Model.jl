using LinearAlgebra

abstract type AbstractNeuralNetwork end
abstract type AbstractNeuronLayer end

mutable struct NeuralNetwork{T<:AbstractNeuronLayer} <: AbstractNeuralNetwork
    layers::AbstractVector{T}
end

mutable struct NeuronLayer{T<:AbstractFloat} <: AbstractNeuronLayer
    weights::AbstractArray{T}
    activator
end

NeuralNetwork{T}() where T = NeuralNetwork{T}([])
NeuralNetwork(args...) = NeuralNetwork{NeuronLayer{Float64}}(args...)

NeuronLayer{T}(num_input::Integer, num_output::Integer, activator) where T = NeuronLayer{T}(rand(num_input, num_output), activator)
NeuronLayer{T}() where T = NeuronLayer{T}([], identity)
NeuronLayer(args...) = NeuronLayer{Float64}(args...)


layers(network::AbstractNeuralNetwork) = network.layers
neurons(layer::AbstractNeuronLayer)    = layer.weights
activator(layer::AbstractNeuronLayer)  = layer.activator


function process(network::NeuralNetwork, input::AbstractArray{<:AbstractFloat})
    values = input
    for layer in layers(network)
        values = activator(layer).(values * neurons(layer))
    end
    values
end
