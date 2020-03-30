reciprocal(value::Integer) = 1//value
reciprocal(value::AbstractFloat) = 1/value
reciprocal(node::AbstractCompGraphNode) = CompGraphReciprocal(node)
reciprocal(node::CompGraphReciprocal) = node.wrap

negate(value::Number) = -value
negate(node::AbstractCompGraphNode) = -node


contains(node::CompGraphConstant,   var::CompGraphVariable) = false
contains(node::CompGraphVariable,   var::CompGraphVariable) = node == var
contains(node::CompGraphNegation,   var::CompGraphVariable) = contains(node.wrap, var)
contains(node::CompGraphReciprocal, var::CompGraphVariable) = contains(node.wrap, var)
contains(node::CompGraphPower,      var::CompGraphVariable) = contains(node.base, var) || contains(node.power, var)

function contains(node::Union{CompGraphAddition, CompGraphMultiplication}, var::CompGraphVariable)
    for operand ∈ node.operands
        if contains(operand, var)
            return true
        end
    end
    return false
end
