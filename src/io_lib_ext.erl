-module(io_lib_ext).

-export([ strip_non_printable_characters/1 ]).

is_not_control_code(C) when C > 127           -> true;
is_not_control_code(C) when C < 32; C =:= 127 -> false;
is_not_control_code(_C)                       -> true.

strip_non_printable_characters(String) ->
  lists:filter(fun is_not_control_code/1, String).
