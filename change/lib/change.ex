defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(_, target) when target < 0, do: error()
  def generate(_, 0), do: result([])

  def generate(coins, target) do
    case valid_target(coins, target) do
      true ->
        coins
        |> Enum.sort()
        |> make_change(target, [])
        |> result()

      false ->
        error()
    end
  end

  defp valid_target([head | _coins], target) when target >= head, do: true
  defp valid_target([head | coins], target) when target < head, do: valid_target(coins, target)
  defp valid_target([], _), do: false

  defp make_change([], _target, _acc), do: nil
  defp make_change(_coins, 0, acc), do: Enum.reverse(acc)

  defp make_change([coin | bigger_coins] = coins, target, acc) when coin <= target do
    make_change(bigger_coins, target, acc) || make_change(coins, target - coin, [coin | acc])
  end

  defp make_change([_coin | bigger_coins], target, acc),
    do: make_change(bigger_coins, target, acc)

  defp result(nil), do: error()
  defp result(coins), do: {:ok, coins}

  defp error(), do: {:error, "cannot change"}
end
