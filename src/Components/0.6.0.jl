module v0_6
using ..Overseer
using ..v0_5
using ..RomeoDFT: MagneticVectorType, ColinMatrixType, State, PostProcessSettings, AbstractResults
using ..v0_2
"""
    IntersectionSearcher

Searcher that is part of a search over all intersections (midpoints) between previously found metastable states.
- `mindist`: minimum Euclidean distance to other trials for an intersection to be accepted.
- `max_intersections_per_generation`: maximum number of new trials for each generation. Most "distant" Trials will be used. 
"""
@pooled_component Base.@kwdef mutable struct IntersectionSearcher
    mindist::Float64 = 0.25
    max_intersections_per_generation::Int = 100
end
function Base.convert(::Type{IntersectionSearcher}, x::v0_5.IntersectionSearcher)
    return IntersectionSearcher(mindist=x.mindist)
end

"""
    StopCondition

This controls when to stop the search.
When the number of unique new states per trial is below the `unique_ratio` for `n_generations` consecutive generations,
the stop condition is met and the search will go in finalizing mode i.e. finish running trials and cleanup.
"""
Base.@kwdef mutable struct StopCondition
    unique_ratio::Float64 = 0.1
    n_generations::Int = 3
end

"""
    Results

Component holding the important results of SCF calculations.
"""
@component struct Results <: AbstractResults
    state::State{Float64, MagneticVectorType, ColinMatrixType}
    constraining_steps::Int
    closest_to_target::Float64
    total_energy::Float64
    Hubbard_energy::Float64
    niterations::Int
    converged::Bool
    fermi::Float64
    accuracy::Float64
end
function Base.convert(::Type{Results}, x::v0_2.Results)
    return Results(x.state, x.constraining_steps, x.closest_to_target, x.total_energy, x.Hubbard_energy, x.niterations, x.converged, x.fermi, x.converged ? 0.0 : typemax(Float64))
end

@component struct Bin
    child::Entity
end

"""
Settings to control PP calculations
"""
@pooled_component Base.@kwdef struct PPSettings <: PostProcessSettings
    flags::Dict{Symbol, Any} = Dict{Symbol, Any}()
end

"""
Settings to control PP calculations
"""
@pooled_component Base.@kwdef struct ElectrideSettings <: PostProcessSettings
    range_below::Float64 = 0.2
    range_above::Float64 = 0.2
end

"""
    RandomSearchSettings
nsearchers: the total budget of random generated trials
"""
@pooled_component Base.@kwdef struct RandomSearchSettings
    nsearchers::Int=50
end
Base.convert(::Type{RandomSearchSettings}, x::v0_5.RandomSearcher) =
    RandomSearchSettings(x.nsearchers)

end
