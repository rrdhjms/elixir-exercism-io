defmodule Bob do
  def hey(input) do
    cond do
      shouting?(input) && question?(input) && !contains_number?(input) ->
        "Calm down, I know what I'm doing!"

      shouting?(input) && !silence?(input) && !contains_only_numbers?(input) ->
        "Whoa, chill out!"

      question?(input) ->
        "Sure."

      silence?(input) ->
        "Fine. Be that way!"

      true ->
        "Whatever."
    end
  end

  defp shouting?(input) do
    input == String.upcase(input)
  end

  defp question?(input) do
    String.last(input) == "?"
  end

  defp silence?(input) do
    String.trim(input) == ""
  end

  defp contains_number?(input) do
    Regex.match?(~r/[0-9]/, input)
  end

  defp contains_only_numbers?(input) do
    String.trim(String.replace(input, ~r/([0-9]|,|\?)/, "")) == ""
  end
end
