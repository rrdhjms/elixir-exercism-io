defmodule Scrabble do
  @one ["a", "e", "i", "o", "u", "l", "n", "r", "s", "t"]
  @two ["d", "g"]
  @three ["b", "c", "m", "p"]
  @four ["f", "h", "v", "w", "y"]
  @five ["k"]
  @eight ["j", "x"]
  @ten ["q", "z"]
  @doc """
  Calculate the scrabble score for the word.
  """

  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.reduce(0, fn elem, acc ->
      acc + add_score(elem)
    end)
  end

  defp add_score(char) do
    cond do
      char in @one -> 1
      char in @two -> 2
      char in @three -> 3
      char in @four -> 4
      char in @five -> 5
      char in @eight -> 8
      char in @ten -> 10
      true -> 0
    end
  end
end
