defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
    if(String.match?(question, ~r/[\d]/)) do
      question
      |> String.downcase()
      |> String.replace("?", "")
      |> String.split(" ")
      |> parse_wordy()
    else
      raise(ArgumentError)
    end
  end

  defp parse_wordy(["what", "is", num | tail]) do
    do_op(String.to_integer(num), tail)
  end

  defp parse_wordy(_list) do
    throw(ArgumentError)
  end

  defp do_op(num, ["plus", num2 | tail]), do: do_op(num + String.to_integer(num2), tail)
  defp do_op(num, ["minus", num2 | tail]), do: do_op(num - String.to_integer(num2), tail)
  defp do_op(num, ["divided", "by", num2 | tail]), do: do_op(num / String.to_integer(num2), tail)

  defp do_op(num, ["multiplied", "by", num2 | tail]),
    do: do_op(num * String.to_integer(num2), tail)

  defp do_op(num, []), do: num
  defp do_op(_num, _list), do: raise(ArgumentError)
end
