defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    alphabet_set = get_alphabet_set()

    sentence
    |> String.downcase
    |> String.graphemes
    |> MapSet.new
    |> MapSet.intersection(alphabet_set)
    |> MapSet.equal?(alphabet_set)
  end

  defp get_alphabet_set() do
    alphabet = for n <- ?a..?z, do: << n :: utf8 >>

    MapSet.new(alphabet)
  end
end
