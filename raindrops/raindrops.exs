defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    factors = convert([], 1, number)
    transform_factors("", factors, number)
  end

  defp convert(factors, factor, number) do
    case should_continue?(factor) do
       true ->
          case rem(number, factor) do
            0 -> convert([factor | factors], factor + 1, number)
            _ -> convert(factors, factor + 1, number)
          end
        _ -> Enum.reverse(factors)
    end
  end

  defp transform_factors("", [], number) do
    Integer.to_string(number)
  end
  defp transform_factors(result, [], _number) do
    result
  end
  defp transform_factors(result, [factor | others], number) do
    transformed =
      get_raindrop_factors()
      |> Map.get(factor, "")

    transform_factors(result <> transformed, others, number)
  end

  defp should_continue?(factor) do
    factor <= get_max_factor()
  end

  defp get_raindrop_factors() do
    %{
      3 => "Pling",
      5 => "Plang",
      7 => "Plong"
    }
  end

  def get_max_factor() do
    get_raindrop_factors
    |> Map.keys
    |> Enum.max
  end
end
