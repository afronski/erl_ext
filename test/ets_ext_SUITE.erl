-module(ets_ext_SUITE).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(MAXIMUM_SIZE, 100).

-export([ all/0, init_per_testcase/2, end_per_testcase/2 ]).
-export([ happy_path_for_listing_all_keys_in_ETS_table/1,
          happy_path_for_empty_ETS_table/1 ]).

all() ->
  [ happy_path_for_listing_all_keys_in_ETS_table,
    happy_path_for_empty_ETS_table ].

init_per_testcase(happy_path_for_listing_all_keys_in_ETS_table, Config) ->
  TableId = ets:new(ets_ext_keys_test, [ordered_set, public]),
  lists:foreach(fun(I) -> ets:insert(TableId, {I, I}) end, lists:seq(1, ?MAXIMUM_SIZE)),
  [ {table, TableId} | Config];

init_per_testcase(happy_path_for_empty_ETS_table, Config) ->
  TableId = ets:new(ets_ext_keys_test, [bag, public]),
  [ {table, TableId} | Config].

happy_path_for_listing_all_keys_in_ETS_table(Config) ->
  TableId = ?config(table, Config),

  Keys = ets_ext:keys(TableId),

  ?assertEqual(?MAXIMUM_SIZE, length(Keys)),
  ?assertEqual(?MAXIMUM_SIZE, lists:last(lists:sort(Keys))).

happy_path_for_empty_ETS_table(Config) ->
  TableId = ?config(table, Config),

  Keys = ets_ext:keys(TableId),

  ?assertEqual(0, length(Keys)).

end_per_testcase(_, Config) ->
  ets:delete(?config(table, Config)).
