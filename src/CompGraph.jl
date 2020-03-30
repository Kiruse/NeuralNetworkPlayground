module CompGraph

comparison_threshold = 1e-9

function set_comparison_threshold(value::Number)
    global comparison_threshold
    comparison_threshold = value
end

get_comparison_threshold() = comparison_threshold

include("./CompGraph.nodes.jl")
include("./CompGraph.operators.jl")
include("./CompGraph.normalize.jl")
include("./CompGraph.compute.jl")
include("./CompGraph.misc.jl")

values(vals::Vararg{Number}) = [CompGraphConstant(val) for val ∈ vals]
variables(count::Integer) = [CompGraphVariable() for val ∈ 1:count]
assign!(node::CompGraphVariable, value::Number) = (node.value = value; node)

end # module
