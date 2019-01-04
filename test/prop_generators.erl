-module(prop_generators).

-include_lib("proper/include/proper.hrl").

-export([ two_lists_with_equal_length/1,
          two_non_empty_lists_with_unequal_length/1,
          two_non_empty_lists_with_first_longer/1,
          two_non_empty_lists_with_second_longer/1
        ]).

-define(MAX_RANGE, 1000).

two_lists_up_to(Size, Type) ->
  ?LET(X, Size, {vector(X, Type), vector(X, Type)}).

two_lists_up_to(SizeA, SizeB, Type) ->
  ?LET({X, Y}, {SizeA, SizeB}, {vector(X, Type), vector(Y, Type)}).

two_lists_with_equal_length(Type) ->
  Size = choose(0, ?MAX_RANGE),
  two_lists_up_to(Size, Type).

two_non_empty_lists_with_unequal_length(Type) ->
  {SizeA, SizeB} = ?SUCHTHAT({Size1, Size2}, {choose(1, ?MAX_RANGE), choose(1, ?MAX_RANGE)}, Size1 =/= Size2),
  two_lists_up_to(SizeA, SizeB, Type).

two_non_empty_lists_with_first_longer(Type) ->
  {SizeA, SizeB} = ?SUCHTHAT({Size1, Size2}, {choose(1, ?MAX_RANGE), choose(1, ?MAX_RANGE)}, Size1 > Size2),
  two_lists_up_to(SizeA, SizeB, Type).

two_non_empty_lists_with_second_longer(Type) ->
  {SizeA, SizeB} = ?SUCHTHAT({Size1, Size2}, {choose(1, ?MAX_RANGE), choose(1, ?MAX_RANGE)}, Size1 < Size2),
  two_lists_up_to(SizeA, SizeB, Type).
