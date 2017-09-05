defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep(list, fun) do
    keep([], list, fun)
  end

  defp keep(accum, [], _fun) do
    Enum.reverse(accum)
  end

  defp keep(accum, [head | tail], fun) do
    applyResult = Kernel.apply(fun, [head])

    case applyResult do
      true -> keep([head | accum], tail, fun)
      _ -> keep(accum, tail, fun)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard(list, fun) do
    discard([], list, fun)
  end

  defp discard(accum, [], _fun) do
    Enum.reverse(accum)
  end

  defp discard(accum, [head | tail], fun) do
    applyResult = Kernel.apply(fun, [head])

    case applyResult do
      true -> discard(accum, tail, fun)
      _ -> discard([head | accum], tail, fun)
    end
  end
end
