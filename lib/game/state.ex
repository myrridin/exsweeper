defmodule ExSweeper.Game.State do
  defstruct board: [], mines: 0, turns: 0
  alias ExSweeper.Game.Cell

  def new(width, height, mines) do
    cells = for _ <- 1..((width*height) - mines) do
      %Cell{}
    end
    mines = for _ <- 1..mines do
      %Cell{bomb: true}
    end

    build_board(width, height, Enum.shuffle(cells ++ mines), [])
  end

  defp build_board(_, 0, [], board), do: board
  defp build_board(w, h, cells, board) do
    {row, new_cells} = build_row(w, cells, [])
    build_board(w, h-1, new_cells, [row | board])
  end

  defp build_row(0, cells, row), do: {row, cells}
  defp build_row(w, cells, row) do
    [cell | new_cells] = cells
    build_row(w-1, new_cells, [cell | row])
  end


  # TODO Take this out. Rendering should move to an external piece
  def text_render(board) do
    for row <- board do
      row_text = for cell <- row do
        render_cell(cell)
      end
      IO.puts Enum.join(row_text)
    end
  end

  defp get_board_width(board) do
    board |> hd |> Enum.size
  end
  defp get_board_height(board) do
    board |> Enum.size
  end

  defp render_cell(%Cell{bomb: false}), do: "."
  defp render_cell(%Cell{bomb: true}), do: "*"
end
