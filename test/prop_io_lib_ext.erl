-module(prop_io_lib_ext).

-include_lib("proper/include/proper.hrl").

prop_after_generating_string_containing_only_control_codes_and_stripping_we_should_get_empty_string() ->
    ?FORALL(StringWithOnlyControlCodes, prop_generators:string_containing_only_control_codes(),
    begin
      io_lib_ext:strip_non_printable_characters(StringWithOnlyControlCodes) =:= ""
    end).
