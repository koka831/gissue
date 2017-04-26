defmodule CliTest do
  use ExUnit.Case
  doctest Gissue

  # import Gissue.CLI.*** functions only being mentioned.
  # usage:
  # only: [def name: number of arg]
  import Gissue.CLI, only: [parse_args: 1,
                            sort_into_ascending_order: 1,
                            convert_to_list_of_maps: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
    assert parse_args(["anything", "--h"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "sort ascending orders the correct way" do
    result = sort_into_ascending_order(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: issue["created_at"]
    assert issues == ~w{a b c}
  end

  defp fake_created_at_list(values) do
    data = for value <- values,
      do: [{"created_at", value}, {"other_data", "xxx"}]
    convert_to_list_of_maps data
  end
end
