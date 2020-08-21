defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    convert(number)
  end


  def convert(n) when n >= 1000, do: change(n, "M", 1000)
  def convert(n) when n >= 900,  do: change(n, "CM", 900)
  def convert(n) when n >= 500,  do: change(n, "D", 500)
  def convert(n) when n >= 400,  do: change(n, "CD", 400)
  def convert(n) when n >= 100,  do: change(n, "C", 100)
  def convert(n) when n >= 90,   do: change(n, "XC", 90)
  def convert(n) when n >= 50,   do: change(n, "L", 50)
  def convert(n) when n >= 40,   do: change(n, "XL", 40)
  def convert(n) when n >= 10,   do: change(n, "X", 10)
  def convert(9),                do: "IX"
  def convert(n) when n >= 5,    do: change(n, "V", 5)
  def convert(4),                do: "IV"
  def convert(n),                do: String.duplicate("I", n)

  defp change(total, roman, number) do
    String.duplicate(roman, div(total, number)) <> convert(rem(total, number))
  end
end
