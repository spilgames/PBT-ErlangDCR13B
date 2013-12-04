-module(lists_examples_eunit).

-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").

-compile(export_all).

-define(PROPER_WRAPPER(Tests), ?_assertEqual(true, proper:quickcheck(Tests, [{to_file, user}]))).

index_of_test_() ->
    [
        {"manual entries", index_of_manual()},
        {"example 1", ?PROPER_WRAPPER(index_of_example1())}
    ].

index_of_manual() ->
    [
        ?_assertEqual({error, not_found}, lists_examples:index_of(0, [])),
        ?_assertEqual({error, not_found}, lists_examples:index_of(0, [yadda, yoda])),

        ?_assertEqual({ok, 0}, lists_examples:index_of(0, [0])),
        ?_assertEqual({ok, 0}, lists_examples:index_of(0, [0, 0])),
        ?_assertEqual({ok, 1}, lists_examples:index_of(1, [0, 1]))
    ].

index_of_example1() ->
    ?FORALL(L1, list(),
        ?FORALL(Elem, term(),
            ?FORALL(L2, list(),
            begin
                FullList = L1 ++ [Elem] ++ L2,
                {ok, length(L1)} == lists_examples:index_of(Elem, FullList)
            end
    ))).

remove_duplicates_test_() ->
    [
        {"proper", ?PROPER_WRAPPER(
            ?FORALL(L, list(nat()),
            begin
                L2 = lists_examples:remove_duplicates(L),
                IndexedL1 = lists:zip(L, lists:seq(1, length(L))),
                {IncreasingIndexes, _} = lists:foldl(fun(E, {B, PrevIdx}) ->
                        Idx = proplists:get_value(E, IndexedL1),
                        {B andalso (Idx > PrevIdx), Idx}
                end, {true, 0}, L2),
                IncreasingIndexes == true
            end
        ))}
    ].