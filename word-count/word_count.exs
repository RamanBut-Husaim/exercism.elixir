defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    sentence
    |> String.replace(~r/([^\w-]|_)+/u, " ")
    |> String.downcase
    |> String.split
    |> Enum.reduce(%{}, fn (el, acc) -> Map.update(acc, el, 1, &(&1 + 1)) end)
  end
end
