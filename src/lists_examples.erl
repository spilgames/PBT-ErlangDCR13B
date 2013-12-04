-module(lists_examples).

-export([index_of/2, remove_duplicates/1]).

%% @doc Index of a first element in a list.
-spec index_of(term(), list(term())) ->
    {ok, non_neg_integer()} |
    {error, not_found}.
%% @end
index_of(Item, List) -> index_of(Item, List, 0).

index_of(_, [], _)  ->
    {error, not_found};
index_of(Item, [Item|_], Index) ->
    {ok, Index};
index_of(Item, [_|Tail], Index) ->
    index_of(Item, Tail, Index+1).


%% @doc Removes the duplicates from the input list.
%% This function preserves the original order.
-spec remove_duplicates([term()]) -> [term()].
%% @end
remove_duplicates(List) ->
    List.
