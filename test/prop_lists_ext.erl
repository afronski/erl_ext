-module(prop_lists_ext).

-include_lib("proper/include/proper.hrl").

prop_zip_uneven_lists_for_lists_with_equal_size_it_should_behave_like_normal_lists_zip() ->
  ?FORALL({ListA, ListB}, prop_generators:two_lists_with_equal_length(integer()),
    begin
      lists_ext:zip_uneven_lists(ListA, ListB) =:= lists:zip(ListA, ListB)
    end).

prop_zip_uneven_lists_for_lists_with_equal_size_default_value_is_ignored() ->
  ?FORALL({ListA, ListB}, prop_generators:two_lists_with_equal_length(integer()),
    begin
      lists_ext:zip_uneven_lists(ListA, ListB, default) =:= lists:zip(ListA, ListB)
    end).

prop_zip_uneven_lists_output_list_length_is_equal_to_the_length_of_the_longer_one() ->
  ?FORALL({ListA, ListB}, {list(integer()), list(integer())},
    begin
      length(lists_ext:zip_uneven_lists(ListA, ListB)) =:= max(length(ListA), length(ListB))
    end).

prop_zip_uneven_lists_last_element_in_output_list_contains_default_element_on_2nd_place() ->
  ?FORALL({ListA, ListB}, prop_generators:two_non_empty_lists_with_unequal_length(integer()),
    begin
      element(2, lists:last(lists_ext:zip_uneven_lists(ListA, ListB))) =:= null
    end).

prop_zip_uneven_lists_last_element_in_output_list_contains_passed_default_element_on_2nd_place() ->
  ?FORALL({ListA, ListB}, prop_generators:two_non_empty_lists_with_unequal_length(integer()),
    begin
      element(2, lists:last(lists_ext:zip_uneven_lists(ListA, ListB, default))) =:= default
    end).


prop_zip_uneven_lists_stable_for_lists_with_equal_size_it_should_behave_like_normal_lists_zip() ->
  ?FORALL({ListA, ListB}, prop_generators:two_lists_with_equal_length(integer()),
    begin
      lists_ext:zip_uneven_lists_stable(ListA, ListB) =:= lists:zip(ListA, ListB)
    end).

prop_zip_uneven_lists_stable_for_lists_with_equal_size_default_value_is_ignored() ->
  ?FORALL({ListA, ListB}, prop_generators:two_lists_with_equal_length(integer()),
    begin
      lists_ext:zip_uneven_lists_stable(ListA, ListB, default) =:= lists:zip(ListA, ListB)
    end).

prop_zip_uneven_lists_stable_output_list_length_is_equal_to_the_length_of_the_longer_one() ->
  ?FORALL({ListA, ListB}, {list(integer()), list(integer())},
    begin
      length(lists_ext:zip_uneven_lists_stable(ListA, ListB)) =:= max(length(ListA), length(ListB))
    end).

prop_zip_uneven_lists_stable_for_longer_ListA_default_value_should_be_at_the_end_on_2nd_position() ->
  ?FORALL({ListA, ListB}, prop_generators:two_non_empty_lists_with_first_longer(integer()),
    begin
      element(2, lists:last(lists_ext:zip_uneven_lists_stable(ListA, ListB))) =:= null
    end).

prop_zip_uneven_lists_stable_for_longer_ListA_passed_default_value_should_be_at_the_end_on_2nd_position() ->
  ?FORALL({ListA, ListB}, prop_generators:two_non_empty_lists_with_first_longer(integer()),
    begin
      element(2, lists:last(lists_ext:zip_uneven_lists_stable(ListA, ListB, default))) =:= default
    end).

prop_zip_uneven_lists_stable_for_longer_ListB_default_value_should_be_at_the_end_on_1st_position() ->
  ?FORALL({ListA, ListB}, prop_generators:two_non_empty_lists_with_second_longer(integer()),
    begin
      element(1, lists:last(lists_ext:zip_uneven_lists_stable(ListA, ListB))) =:= null
    end).

prop_zip_uneven_lists_stable_for_longer_ListB_passed_default_value_should_be_at_the_end_on_1st_position() ->
  ?FORALL({ListA, ListB}, prop_generators:two_non_empty_lists_with_second_longer(integer()),
    begin
      element(1, lists:last(lists_ext:zip_uneven_lists_stable(ListA, ListB, default))) =:= default
    end).
