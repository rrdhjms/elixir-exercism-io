defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency([], _workers), do: %{}

  def frequency(texts, 1) do
    texts
    |> get_graphemes()
    |> count_letters()
  end

  def frequency(texts, workers) do
    texts
    |> get_graphemes()
    |> split_into_chunks(workers)
    |> Task.async_stream(&count_letters/1)
    |> merge_results_stream()
  end

  defp get_graphemes(texts) do
    texts
    |> Enum.join()
    |> String.graphemes()
  end

  defp count_letters(letters) do
    Enum.reduce(letters, %{}, fn letter, acc ->
      if(String.match?(letter, ~r/^\p{L}$/u)) do
        downcased = String.downcase(letter)
        Map.update(acc, downcased, 1, fn val -> val + 1 end)
      else
        acc
      end
    end)
  end

  defp split_into_chunks(all_graphemes, num_chunks) do
    all_graphemes_count = Enum.count(all_graphemes)
    graphemes_per_chunk = :erlang.ceil(all_graphemes_count / num_chunks)

    Enum.chunk_every(all_graphemes, graphemes_per_chunk)
  end

  defp merge_results_stream(results_stream) do
    Enum.reduce(results_stream, %{}, fn {:ok, worker_result}, acc ->
      Map.merge(acc, worker_result, fn _key, acc_val, worker_val ->
        acc_val + worker_val
      end)
    end)
  end
end
