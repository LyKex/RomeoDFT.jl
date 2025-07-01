
## Design principles

`Romeo` use Entity Component System (ECS) to seperate data (job, structure, results, etc) and logic (submission, search proposal, postprocessing, etc). ECS is highly dynamic and efficient architecture and is implemented through [`Overseer.jl`](https://github.com/louisponet/Overseer.jl).

Some key concepts need to understand in order to modify the code.

`Entity`
	Nothing but an index that points to a entry in a continuous array, `Component`.

`Component`
	Array of a specific type that is indexed by `Entity`. The implementation of `Overseer.jl` makes sure that the retrieval by `Entity` and by `Component` (eg. get all entities with certain components) are both fast. Useful methods for iteration: `@entities_in`, `@safe_entities_in`


`System`
	An empty struct that a logic operating on entities and components by overloading `Overseer.udpates` and `Overseer.requested_components`. 

`Stage`
	To group a vector of `Systems` to perform more complicated tasks in a parallel way. This is how the final workflow is defined.


## Related Systems

RandomTrialGenerator
