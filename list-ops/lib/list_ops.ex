defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_head | tail]), do: 1 + count(tail)

  @spec reverse(list) :: list
  def reverse(l), do: reverse(l, [])
  def reverse([], l), do: l
  def reverse([head | tail], l), do: reverse(tail, [head | l])

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    map(l, f, [])
  end

  def map([], _f, output), do: reverse(output)
  def map([head | tail], f, output), do: map(tail, f, [f.(head) | output])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter(l, f, [])
  end

  def filter([], _f, output), do: reverse(output)

  def filter([head | tail], f, output) do
    case f.(head) do
      true -> filter(tail, f, [head | output])
      _ -> filter(tail, f, output)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([head | tail], acc, f), do: reduce(tail, f.(head, acc), f)

  @spec append(list, list) :: list
  def append(a, []), do: a
  def append([], b), do: b
  def append([ah | at], b), do: [ah | append(at, b)]

  @spec concat([[any]]) :: [any]
  def concat(ll), do: concat(ll, [])

  def concat([], output), do: reverse(output)
  def concat([head | tail], output), do: concat(tail, append(reverse(head), output))
end
