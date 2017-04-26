defmodule CliTest do
  use ExUnit.Case
  doctest Gissue

  # import Gissue.CLI.*** functions only being mentioned.
  # usage:
  # only: [def name: number of arg]
  import Gissue.CLI, only: [parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
    assert parse_args(["anything", "--h"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end
end
