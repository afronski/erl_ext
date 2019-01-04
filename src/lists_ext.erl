-module(lists_ext).

-export([ zip_uneven_lists/2,
          zip_uneven_lists/3
        ]).

-spec zip_uneven_lists(list(any()), list(any())) -> list(any()).
zip_uneven_lists(L1, L2) ->
  zip_uneven_lists(L1, L2, undefined).

-spec zip_uneven_lists(list(any()), list(any()), any()) -> list(any()).
zip_uneven_lists(L1, L2, Default) ->
  LenL1 = length(L1),
  LenL2 = length(L2),
  zip_uneven_lists_stable(L1, LenL1, L2, LenL2, Default).

-spec zip_uneven_lists_stable(list(any()), non_neg_integer(), list(any()), non_neg_integer(), any()) -> list(any()).
zip_uneven_lists_stable(L1, LenL1, L2, LenL2, Default) ->
  MissingElementsCount = abs(LenL1 - LenL2),
  Padding = lists:duplicate(MissingElementsCount, Default),

  case LenL1 > LenL2 of
    true ->
      ExpandedShorter = lists:concat([L2, Padding]),
      lists:zip(L1, ExpandedShorter);

    _ ->
      ExpandedShorter = lists:concat([L1, Padding]),
      lists:zip(ExpandedShorter, L2)
  end.
