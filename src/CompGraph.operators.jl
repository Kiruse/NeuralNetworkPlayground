# Identity

Base.:+(node::AbstractCompGraphNode) = node

# Negation

Base.:-(node::CompGraphConstant)       = CompGraphConstant(-node.value)
Base.:-(node::CompGraphNegation)       = node.wrap
Base.:-(node::CompGraphAddition)       = CompGraphAddition([-operand for operand in node.operands])
Base.:-(node::CompGraphMultiplication) = CompGraphMultiplication(vcat([-node.operands[1]], node.operands[2:length(node.operands)]))
Base.:-(node::CompGraphPower)          = CompGraphPower(-node.base, node.power)
Base.:-(node::AbstractCompGraphNode)   = CompGraphNegation(node)

# Addition

Base.:+(lhs::AbstractCompGraphNode, rhs::AbstractCompGraphNode) = CompGraphAddition([lhs, rhs])
Base.:+(lhs::AbstractCompGraphNode, rhs::Number)                = lhs + CompGraphConstant(rhs)
Base.:+(lhs::Number,                rhs::AbstractCompGraphNode) = rhs + lhs
Base.:+(lhs::AbstractCompGraphNode, rhs::CompGraphAddition)     = rhs + lhs
Base.:+(lhs::CompGraphConstant,     rhs::CompGraphConstant)     = CompGraphConstant(lhs.value + rhs.value)
Base.:+(lhs::CompGraphAddition,     rhs::CompGraphAddition)     = CompGraphAddition(vcat(lhs.operands, rhs.operands))
Base.:+(lhs::CompGraphAddition,     rhs::AbstractCompGraphNode) = (push!(lhs.operands, rhs); lhs)

# Subtraction

Base.:-(lhs::AbstractCompGraphNode, rhs::AbstractCompGraphNode) = lhs + negate(rhs)

# Multiplication

Base.:*(lhs::AbstractCompGraphNode,   rhs::AbstractCompGraphNode)   = CompGraphMultiplication([lhs, rhs])
Base.:*(lhs::Number,                  rhs::AbstractCompGraphNode)   = CompGraphConstant(lhs) * rhs
Base.:*(lhs::AbstractCompGraphNode,   rhs::Number)                  = rhs * lhs
Base.:*(lhs::AbstractCompGraphNode,   rhs::CompGraphMultiplication) = rhs * lhs
Base.:*(lhs::CompGraphConstant,       rhs::CompGraphConstant)       = CompGraphConstant(lhs.value * rhs.value)
Base.:*(lhs::CompGraphMultiplication, rhs::CompGraphMultiplication) = CompGraphMultiplication(vcat(lhs.operands, rhs.operands))
Base.:*(lhs::CompGraphMultiplication, rhs::AbstractCompGraphNode)   = (push!(lhs.operands, rhs); lhs)

# Division

Base.:/(lhs::AbstractCompGraphNode, rhs::AbstractCompGraphNode) = lhs * reciprocal(rhs)

# Power

Base.:^(base::AbstractCompGraphNode, power::AbstractCompGraphNode) = CompGraphPower(base, power)
Base.:^(base::CompGraphPower,        power::AbstractCompGraphNode) = CompGraphPower(base, base.power * power)
Base.:^(base::AbstractCompGraphNode, power::CompGraphPower)        = CompGraphPower(base, power.base * power.power)
Base.:^(base::AbstractCompGraphNode, power::Number)                = CompGraphPower(base, CompGraphConstant(power))
Base.:^(base::Number,                power::AbstractCompGraphNode) = CompGraphPower(CompGraphConstant(base), power)
