defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_s, size) when size <= 0 do
    []
  end

  def slices(s, size) do
    slices([], String.graphemes(s), size)
  end

  defp slices(accum, graphemes, size) when length(graphemes) < size do
    Enum.reverse(accum)
  end

  defp slices(accum, graphemes, size) do
    segment = graphemes
    |> Enum.take(size)
    |> Enum.join

    slices([segment | accum], Kernel.tl(graphemes), size)
  end
end

