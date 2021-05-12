"""
warmup(
    model::MetabolicModel,
    optimizer;
    warmup_points::Vector{Int},
    modifications = [],
    workers = [myid()],

Generates warmup points for samplers by sequentially minimizing and maximizing 
reactions at `warmup_points`. Very similar to [`flux_variability_analysis`](@ref).
"""
function warmup(
    model::MetabolicModel,
    optimizer;
    warmup_points::Vector{Int},
    modifications = [],
    workers = [myid()],
)
    # create optimization problem, apply constraints, load on all workers
    optmodel = make_optimization_model(model, optimizer)
    for mod in modifications
        mod(model, optmodel)
    end

    save_model = :($optmodel)

    map(fetch, save_at.(workers, :cobrexa_hit_and_run_warmup_model, Ref(save_model)))

    ret = m -> value.(m[:x]) # get all the fluxes
    # error occurs here :/
    fluxes = dpmap(
        rid -> :($COBREXA._FVA_optimize_reaction(
            cobrexa_hit_and_run_warmup_model,
            $rid,
            $ret,
        )),
        CachingPool(workers),
        [-warmup_points warmup_points],
    )

    # free the data on workers
    map(fetch, remove_from.(workers, :cobrexa_hit_and_run_warmup_model))
    lbs, ubs = get_bound_vectors(optmodel)

    return fluxes, lbs, ubs
end
