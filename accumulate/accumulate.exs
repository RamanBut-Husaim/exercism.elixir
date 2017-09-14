defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, fun) do
    accumulate([], list, fun)
  end

  defp accumulate(accum, [], _fun) do
    Enum.reverse(accum)
  end

  defp accumulate(accum, [el | other], fun) do
    accumulate([fun.(el) | accum], other, fun)
  end
end
