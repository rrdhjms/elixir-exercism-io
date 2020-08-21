defmodule ProteinTranslation do
  @codon_length ~r/.{3}/
  @stop "STOP"
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    proteins =
      rna
      |> String.split(@codon_length, include_captures: true, trim: true)
      |> Enum.reduce([], &translate/2)
      |> Enum.reverse()

    {:ok, proteins}
  catch
    {:halt, proteins} ->
      {:ok, proteins}

    :error ->
      {:error, "invalid RNA"}
  end

  defp translate(codon, output) do
    codon
    |> of_codon()
    |> apply_protein(output)
  end

  defp apply_protein({:ok, @stop}, acc), do: throw({:halt, Enum.reverse(acc)})
  defp apply_protein({:ok, protein}, acc), do: [protein | acc]
  defp apply_protein({:error, _message}, _acc), do: throw(:error)

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon("UGU"), do: {:ok, "Cysteine"}
  def of_codon("UGC"), do: {:ok, "Cysteine"}
  def of_codon("UUA"), do: {:ok, "Leucine"}
  def of_codon("UUG"), do: {:ok, "Leucine"}
  def of_codon("AUG"), do: {:ok, "Methionine"}
  def of_codon("UUU"), do: {:ok, "Phenylalanine"}
  def of_codon("UUC"), do: {:ok, "Phenylalanine"}
  def of_codon("UCU"), do: {:ok, "Serine"}
  def of_codon("UCC"), do: {:ok, "Serine"}
  def of_codon("UCA"), do: {:ok, "Serine"}
  def of_codon("UCG"), do: {:ok, "Serine"}
  def of_codon("UGG"), do: {:ok, "Tryptophan"}
  def of_codon("UAU"), do: {:ok, "Tyrosine"}
  def of_codon("UAC"), do: {:ok, "Tyrosine"}
  def of_codon("UAA"), do: {:ok, @stop}
  def of_codon("UAG"), do: {:ok, @stop}
  def of_codon("UGA"), do: {:ok, @stop}
  def of_codon(_), do: {:error, "invalid codon"}
end
