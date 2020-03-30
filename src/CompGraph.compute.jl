compute(node::CompGraphConstant) = node.value
compute(node::CompGraphVariable) = if node.value == nothing error("Unassigned variable") else node.value end
compute(node::CompGraphNegation) = -compute(node.wrap)
compute(node::CompGraphReciprocal) = 1 / compute(node.wrap)
compute(node::CompGraphPower) = compute(node.base) ^ compute(node.power)
compute(node::CompGraphAddition) = sum([compute(operand) for operand ∈ node.operands])
compute(node::CompGraphMultiplication) = prod([compute(operand) for operand ∈ node.operands])
