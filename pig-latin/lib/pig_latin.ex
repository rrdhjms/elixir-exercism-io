defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&change/1)
    |> Enum.join(" ")
  end

  defp change(word) do
    word
    |> String.replace(~r/^([^aeiouqxy]+)(.+)/iu, "\\2\\1")
    |> String.replace(~r/^(qu?)(.+)/iu, "\\2\\1")
    |> String.replace(~r/^(y|x)([aeiou].+)/iu, "\\2\\1")
    |> append("ay")
  end

  defp append(word, suffix), do: word <> suffix
end
