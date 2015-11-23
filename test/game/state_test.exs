defmodule StateTest do
  use ExUnit.Case
  alias ExSweeper.Game.State

  test "it can create a new board" do
    {:board, board} = State.new(5, 10, 10)
    IO.puts board
  end

end

