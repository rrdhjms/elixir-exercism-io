defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  def compare(a, a), do: :equal

  def compare(a, b) do
    cond do
      sublist?(a, b) -> :superlist
      sublist?(b, a) -> :sublist
      true -> :unequal
    end
  end

  def sublist?(a, b) when length(a) < length(b), do: false

  def sublist?(a, b) do
    sublist = Enum.take(a, length(b))
    sublist === b or sublist?(tl(a), b)
  end
end
