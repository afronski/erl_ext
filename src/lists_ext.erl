-module(lists_ext).

-export([ zip_uneven_lists/2,
          zip_uneven_lists/3,
          zip_uneven_lists_stable/2,
          zip_uneven_lists_stable/3
        ]).

-spec zip_uneven_lists(list(), list()) -> list().
zip_uneven_lists(L1, L2) -> zip_uneven_lists(L1, L2, undefined).

-spec zip_uneven_lists(list(), list(), any()) -> list().
zip_uneven_lists(L1, L2, _Default) when length(L1) =:= length(L2) -> lists:zip(L1, L2);
zip_uneven_lists(L1, L2, Default) when length(L1) > length(L2)    -> zip_with_default(L1, L2, Default);
zip_uneven_lists(L1, L2, Default) when length(L1) < length(L2)    -> zip_with_default(L2, L1, Default).

-spec zip_with_default(list(), list(), any()) -> list().
zip_with_default(Longer, Shorter, Default) ->
  MissingElementsCount = length(Longer) - length(Shorter),
  Padding = lists:duplicate(MissingElementsCount, Default),
  ExpandedShorter = lists:concat([Shorter, Padding]),
  lists:zip(Longer, ExpandedShorter).

-spec zip_uneven_lists_stable(list(), list()) -> list().
zip_uneven_lists_stable(L1, L2) -> zip_uneven_lists_stable(L1, L2, undefined).

-spec zip_uneven_lists_stable(list(), list(), any()) -> list().
zip_uneven_lists_stable(L1, L2, _Default) when length(L1) =:= length(L2) -> lists:zip(L1, L2);
zip_uneven_lists_stable(L1, L2, Default)                                 -> zip_with_default_stable(L1, L2, Default).

-spec zip_with_default_stable(list(), list(), any()) -> list().
zip_with_default_stable(L1, L2, Default) ->
  MissingElementsCount = abs(length(L1) - length(L2)),
  Padding = lists:duplicate(MissingElementsCount, Default),

  case length(L1) > length(L2) of
    true ->
      ExpandedShorter = lists:concat([L2, Padding]),
      lists:zip(L1, ExpandedShorter);

    _ ->
      ExpandedShorter = lists:concat([L1, Padding]),
      lists:zip(ExpandedShorter, L2)
  end.
