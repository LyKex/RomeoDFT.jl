module v0_3
using ..Overseer
using ..DFControl.Jobs
using ..v0_2
using ..RomeoDFT: State, local_load, PostProcessSettings, AbstractResults
using ..RomeoDFT.DFControl: Projection, Calculation, QE, Structure, Job

"""
    SimJob

Represents a simulation job with a local directory and remote directory where the job will be running.
"""
@component mutable struct SimJob
    local_dir::String
    remote_dir::String
    job::Job
end
function Base.convert(::Type{SimJob}, x::v0_2.SimJob)
    return SimJob(replace(replace(x.local_dir, "0.1.0/" => ""), "0.2.0/" => ""),
                  x.remote_dir,
                  local_load(Job(x.local_dir)))
end

"""
    SCFSettings

Settings for scf calculations, replacements will be used to overwrite flags from the template Calculation.
"""
@component struct SCFSettings <: PostProcessSettings
    replacement_flags::Dict
    kpoints::NTuple{6,Int}
end
function Base.convert(::Type{SCFSettings}, x::v0_2.SCFSettings)
    return SCFSettings(x.replacement_flags, (8, 8, 8, 0, 0, 0))
end

"""
    Error

Component that can be used to signal an error has occurred.
"""
@component struct Error
    msg::String
end

"""
    FlatBands

A flat representation of a bandstructure to be used with [`sssp_distance`](@ref). See also [`add_bands!`](@ref).
"""
@component mutable struct FlatBands <: AbstractResults
    bands::Vector{Float64}
end

"""
    HPSettings

Holds the settings for a HP calculation.
"""
@pooled_component Base.@kwdef struct HPSettings <: PostProcessSettings
    nq::NTuple{3, Int} = (2,2,2)
    conv_thr_chi::Float64 = 1e-6
    find_atpert::Int = 1
    U_conv_thr::Float64 = 0.1
    U_max::Float64 = 15.0
    ethr_nscf::Float64 = 1e-11
end
Base.convert(::Type{HPSettings}, x::v0_2.HPSettings) = HPSettings(x.nq, x.conv_thr_chi, x.find_atpert, x.U_conv_thr, x.U_max, 1e-11)



end
