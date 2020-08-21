defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &complement/1)
    |> List.to_charlist
  end


  defp complement(base) when base == 65, do: 'U'
  defp complement(base) when base == 67, do: 'G'
  defp complement(base) when base == 71, do: 'C'
  defp complement(base) when base == 84, do: 'A'
  defp complement(_), do: '*'

end
