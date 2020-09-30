defmodule MatchingBrackets do
  @pairs [
    {"{", "}"},
    {"[", "]"},
    {"(", ")"}
  ]

  @opening ["{", "[", "("]
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.replace(~r/[^\[\](){}]/, "")
    |> String.graphemes()
    |> check_matching([])
  end

  defp check_matching([], []), do: true
  defp check_matching([], _), do: false

  defp check_matching([opening | rest], check) when opening in @opening,
    do: check_matching(rest, [opening | check])

  defp check_matching([closing | rest], [opening | check])
       when {opening, closing} in @pairs,
       do: check_matching(rest, check)

  defp check_matching(_, _), do: false
end
