-module(ets_ext).

-export([ keys/1 ]).

-spec keys(atom() | ets:tid()) -> list(term()).
keys(TableName) ->
  FirstKey = ets:first(TableName),
  keys(TableName, FirstKey, [ FirstKey ]).

-spec keys(atom() | ets:tid(), term(), list(term)) -> list(term()).
keys(_TableName, '$end_of_table', [ '$end_of_table' | Acc ]) ->
  Acc;
keys(TableName, CurrentKey, Acc) ->
  NextKey = ets:next(TableName, CurrentKey),
  keys(TableName, NextKey, [ NextKey | Acc ]).
