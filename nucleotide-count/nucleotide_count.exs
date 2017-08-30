defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    histogram = histogram(strand)

    Map.get(histogram, nucleotide, 0)
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    accum = %{?A => 0, ?T => 0, ?C => 0, ?G => 0}

    histogram(strand, accum)
  end

  defp histogram([], accum) do
    accum
  end
  defp histogram([n | others], accum) do
    nucleotideCounter = Map.get(accum, n, 0)
    accum = Map.put(accum, n, nucleotideCounter + 1)

    histogram(others, accum)
  end
end
