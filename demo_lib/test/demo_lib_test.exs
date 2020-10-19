defmodule DemoLibTest do
  use ExUnit.Case
  doctest DemoLib

  test "greets the world" do
    assert DemoLib.hello() == :world
  end
end
