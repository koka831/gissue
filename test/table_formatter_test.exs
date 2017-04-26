defmodule TableFormatterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias Gissue.TableFormatter, as: TF

  def simple_test_data do
    [
      [c1: "r1 c1", c2: "r1 c2", c3: "r1 c3", c4: "r1++c4"],
      [c2: "r2 c1", c2: "r2 c2", c3: "r3 c3", c4: "r2 c4"]
    ]
  end

  def headers, do: [:c1, :c2, :c4]

  def split_with_three_columns,
    do: TF.split_into_columns(simple_test_data, headers)

  test "split_into_columns" do
    columns = split_with_three_columns
    assert  length(columns) == length(headers)
    assert  List.first(columns) == ["r1 c1", "r2 c1"]
    assert  List.last(columns) == ["r1++c4", "r2 c4"]
  end
end

