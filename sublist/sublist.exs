defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when length(a) > length(b) do
    compare_internal(a, b)
  end

  def compare(a, b) when length(a) < length(b) do
    comparison_result = compare_internal(b, a)

    case comparison_result do
      :superlist -> :sublist
      _ -> comparison_result
    end
  end

  def compare(a, b) do
    case verify_match(a, b) do
      :ok -> :equal
      _ -> :unequal
    end
  end

  defp compare_internal([], []) do
    :equal
  end

  defp compare_internal([], _b) do
    :unequal
  end

  defp compare_internal(_a, []) do
    :superlist
  end

  defp compare_internal([elem | a_other], [elem | b_other] = b_part) do
    case verify_match(a_other, b_other) do
      :ok -> :superlist
      _ -> compare_internal(a_other, b_part)
    end
  end

  defp compare_internal([_a | a_other], [_b | _b_other] = b_part) do
    compare_internal(a_other, b_part)
  end

  defp verify_match(_a, []) do
    :ok
  end

  defp verify_match([], _b) do
    :none
  end

  defp verify_match([elem | a_other], [elem | b_other]) do
    verify_match(a_other, b_other)
  end

  defp verify_match([_a | _a_other], [_b | _b_other]) do
    :none
  end
end
