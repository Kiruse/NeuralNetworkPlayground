sigmoid(x) = 1 ./ (1 .+ exp.(.-x))
clamp(x)   = max.(0, min.(x, 1))
relu(x)    = max.(0, x)

mse(params) = sum(pair -> (pair[1] - pair[2])^2, params) / length(params)
mse(pairs::Vararg{Tuple{<:Real, <:Real}}) = mse(pairs)

function mse(values::Vararg{<:Real})
    @assert iseven(length(values))
    pairs = []
    for n in 1:2:length(values)
        push!(pairs, (values[n], values[n+1]))
    end
    mse(pairs)
end
