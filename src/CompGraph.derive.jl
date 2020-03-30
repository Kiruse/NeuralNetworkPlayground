derive(node::CompGraphConstant, var::CompGraphVariable) = 0
derive(node::CompGraphVariable, var::CompGraphVariable) = 1

function derive(node::CompGraphPower, var::CompGraphVariable)
    error("I need to brush up on Calculus for this stuff..!")
end
