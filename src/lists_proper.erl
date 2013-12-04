-module(lists_proper).

-include_lib("proper/include/proper.hrl").

-compile([export_all]).

example1() ->
    ?FORALL(L1, list(),
        ?FORALL(Elem, term(),
            ?FORALL(L2, list(),
            begin
                FullList = L1 ++ [Elem] ++ L2,
                {ok, length(L1)} == lists_examples:index_of(Elem, FullList)
            end
    ))).

remove_duplicates_keeps_order_prop() ->
    ?FORALL(L, list(nat()),
        begin
            L2 = elibs_lists:remove_duplicates(L),
            IndexedL1 = lists:zip(L, lists:seq(1, length(L))),
            {IncreasingIndexes, _} = lists:foldl(fun(E, {B, PrevIdx}) ->
                    Idx = proplists:get_value(E, IndexedL1),
                    {B andalso (Idx > PrevIdx), Idx}
            end, {true, 0}, L2),
            IncreasingIndexes == true
        end
    ).