defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    calculate(0, limit, 1, factors)
  end

  defp calculate(sum, limit, current_number, _factors) when current_number >= limit do
    sum
  end

  defp calculate(sum, limit, current_number, factors) when current_number < limit do
    case is_multiple(current_number, factors) do
      true -> calculate(sum + current_number, limit, current_number + 1, factors)
      _ -> calculate(sum, limit, current_number + 1, factors)
    end
  end

  defp is_multiple(_current_number, []) do
    false
  end

  defp is_multiple(current_number, [factor | factors]) do
    case rem(current_number, factor) === 0 do
      true -> true
      _ -> is_multiple(current_number, factors)
    end
  end
end
