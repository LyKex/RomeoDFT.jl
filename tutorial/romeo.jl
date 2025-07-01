### A Pluto.jl notebook ###
# v0.20.8

using Markdown
using InteractiveUtils

# ╔═╡ ee342455-e1a3-40fc-a971-ebf50676bbf8
begin
	using Pkg
	Pkg.activate(".")
	Pkg.develop(path="..")
	using RomeoDFT
	using RomeoDFT: RandomTrialGenerator
end

# ╔═╡ 63d875f4-3adc-11f0-1915-41e2ad0da9c4
md"## Design principles

`Romeo` use Entity Component System (ECS) to seperate data (job, structure, results, etc) and logic (submission, search proposal, postprocessing, etc). ECS is highly dynamic and efficient architecture and is implemented through [`Overseer.jl`](https://github.com/louisponet/Overseer.jl).

Some key concepts need to understand in order to modify the code.

`Entity`: Nothing but an index that points to a entry in a continuous array, `Component`.

`Component`: Array of a specific type that is indexed by `Entity`. The implementation of `Overseer.jl` makes sure that the retrieval by `Entity` and by `Component` (eg. get all entities with certain components) are both fast. Useful methods for iteration: `@entities_in`, `@safe_entities_in`


`System`: An empty struct that a logic operating on entities and components by overloading `Overseer.udpates` and `Overseer.requested_components`. 

`Stage`: To group a vector of `Systems` to perform more complicated tasks in a parallel way. This is how the final workflow is defined."


# ╔═╡ cf445982-8090-4cdc-b58f-dda3a4b223ca
md"# Related Systems"

# ╔═╡ aa95d65f-8e10-481f-8b80-1ca19990c8e3
md"Here is where to experiment different ways to generates new trials. There are 2 aspects of matrix generation: 1) matrix representation and 2) algorithms. We have tried representing with eigen values (diagonal occupations), number of electrons, [Euler angles](https://github.com/louisponet/EulerAngles.jl). For algorithms see `firefily.jl`, `intersection.jl`, `model.jl`"

# ╔═╡ 1270747c-cf53-4ab1-a01c-30d64d3cc8a3
md"# Practical Examples"

# ╔═╡ b93709ae-0c56-4fa8-a8b6-cebbba62ca32
l = load(Searcher("NiO_v028"))

# ╔═╡ 6e67aca3-afd9-4f0b-aca3-3a008f11a20e
l[Results][1].total_energy

# ╔═╡ ec7f19cb-e595-49df-b4bd-838bc9dd9877
gs = ground_state(l)

# ╔═╡ 0282ffeb-c498-48df-83bd-19fcaace0794
l[gs][Template].structure.atoms

# ╔═╡ 7895cc97-d5ce-4ee2-b502-3e23ee3da470
gs.components

# ╔═╡ e05a9ed2-3939-4360-95fb-cfb20a317e00


# ╔═╡ 8ab23f56-324a-439e-81c4-ecc3d85763ad


# ╔═╡ 79b566f6-e1a7-4c63-b598-f18c53159ce6


# ╔═╡ b0f2e9c2-dff1-465a-af51-e3b773d73ec5


# ╔═╡ 1bb80c34-1799-4783-b9b5-b80c9c5b3fe9


# ╔═╡ a34a530a-a3ad-4433-8bb1-c3d65d6a041a


# ╔═╡ 1589fd64-62b3-47e4-b21c-6b6c282b2635


# ╔═╡ f63153ae-bd48-4500-b8a1-045ea7a0f68c


# ╔═╡ 9f43bd1d-8639-43ed-b23c-b40218186153


# ╔═╡ 5eee811c-4f71-4ab5-8770-b6a718f211cc


# ╔═╡ 9c3c74c9-c88a-492a-8c52-c9afc651eed4


# ╔═╡ ac338bc8-e5a8-47e4-b6f8-0ffd5e9c09ce


# ╔═╡ bb9624f3-be7c-437b-bce7-1cc96c84f8ec


# ╔═╡ 2090ea85-d0e0-4b3a-bc8d-5adcb91e106f


# ╔═╡ b3ffe003-9221-4699-8f14-9dd374618f95


# ╔═╡ 50eed7f9-3cc6-4c9e-8172-598d2a1a25c6


# ╔═╡ f9e89a72-80c0-4e91-aa69-43ee936bd03d


# ╔═╡ 066649b4-5102-4f15-bb4e-0be7f98b5524


# ╔═╡ 615b6d7a-a2f1-4d66-9f29-bfbf4922aaf2


# ╔═╡ f7380b99-af96-414a-acc4-1bfad7e7eb4e


# ╔═╡ 75c2dc60-8dc0-46de-b96f-a5ef3e5ffb81


# ╔═╡ c1848492-5f18-41b9-af4c-e60f813fdefa


# ╔═╡ 7abb9113-3a33-43c8-960a-a3200f4033e0


# ╔═╡ Cell order:
# ╠═63d875f4-3adc-11f0-1915-41e2ad0da9c4
# ╠═cf445982-8090-4cdc-b58f-dda3a4b223ca
# ╠═ee342455-e1a3-40fc-a971-ebf50676bbf8
# ╠═aa95d65f-8e10-481f-8b80-1ca19990c8e3
# ╠═1270747c-cf53-4ab1-a01c-30d64d3cc8a3
# ╠═b93709ae-0c56-4fa8-a8b6-cebbba62ca32
# ╠═6e67aca3-afd9-4f0b-aca3-3a008f11a20e
# ╠═ec7f19cb-e595-49df-b4bd-838bc9dd9877
# ╠═0282ffeb-c498-48df-83bd-19fcaace0794
# ╠═7895cc97-d5ce-4ee2-b502-3e23ee3da470
# ╠═e05a9ed2-3939-4360-95fb-cfb20a317e00
# ╠═8ab23f56-324a-439e-81c4-ecc3d85763ad
# ╠═79b566f6-e1a7-4c63-b598-f18c53159ce6
# ╠═b0f2e9c2-dff1-465a-af51-e3b773d73ec5
# ╠═1bb80c34-1799-4783-b9b5-b80c9c5b3fe9
# ╠═a34a530a-a3ad-4433-8bb1-c3d65d6a041a
# ╠═1589fd64-62b3-47e4-b21c-6b6c282b2635
# ╠═f63153ae-bd48-4500-b8a1-045ea7a0f68c
# ╠═9f43bd1d-8639-43ed-b23c-b40218186153
# ╠═5eee811c-4f71-4ab5-8770-b6a718f211cc
# ╠═9c3c74c9-c88a-492a-8c52-c9afc651eed4
# ╠═ac338bc8-e5a8-47e4-b6f8-0ffd5e9c09ce
# ╠═bb9624f3-be7c-437b-bce7-1cc96c84f8ec
# ╠═2090ea85-d0e0-4b3a-bc8d-5adcb91e106f
# ╠═b3ffe003-9221-4699-8f14-9dd374618f95
# ╠═50eed7f9-3cc6-4c9e-8172-598d2a1a25c6
# ╠═f9e89a72-80c0-4e91-aa69-43ee936bd03d
# ╠═066649b4-5102-4f15-bb4e-0be7f98b5524
# ╠═615b6d7a-a2f1-4d66-9f29-bfbf4922aaf2
# ╠═f7380b99-af96-414a-acc4-1bfad7e7eb4e
# ╠═75c2dc60-8dc0-46de-b96f-a5ef3e5ffb81
# ╠═c1848492-5f18-41b9-af4c-e60f813fdefa
# ╠═7abb9113-3a33-43c8-960a-a3200f4033e0
