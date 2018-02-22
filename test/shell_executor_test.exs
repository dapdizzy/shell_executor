defmodule ShellExecutorTest do
  use ExUnit.Case
  doctest ShellExecutor

  test "greets the world" do
    assert ShellExecutor.hello() == :world
  end
end
