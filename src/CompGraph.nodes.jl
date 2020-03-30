abstract type AbstractCompGraphNode end
abstract type AbstractCompGraphValueNode <: AbstractCompGraphNode end
abstract type AbstractCompGraphOperatorNode <: AbstractCompGraphNode end
abstract type AbstractCompGraphUnaryOperatorNode <: AbstractCompGraphOperatorNode end
abstract type AbstractCompGraphBinaryOperatorNode <: AbstractCompGraphOperatorNode end

struct CompGraphConstant <: AbstractCompGraphValueNode
    value::Number
end

mutable struct CompGraphVariable <: AbstractCompGraphValueNode
    value::Union{Nothing, Number}
end
CompGraphVariable() = CompGraphVariable(nothing)

struct CompGraphNegation <: AbstractCompGraphUnaryOperatorNode
    wrap::AbstractCompGraphNode
end

struct CompGraphReciprocal <: AbstractCompGraphUnaryOperatorNode
    wrap::AbstractCompGraphNode
end

struct CompGraphPower <: AbstractCompGraphUnaryOperatorNode
    base::AbstractCompGraphNode
    power::AbstractCompGraphNode
end

struct CompGraphAddition <: AbstractCompGraphBinaryOperatorNode
    operands::AbstractVector{AbstractCompGraphNode}
end

struct CompGraphMultiplication <: AbstractCompGraphBinaryOperatorNode
    operands::AbstractVector{AbstractCompGraphNode}
end
