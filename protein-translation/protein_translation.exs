defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: { atom,  list(String.t()) }
  def of_rna(rna) do
    codons =
      rna
      |> String.graphemes
      |> Enum.chunk_every(3)
      |> Enum.map(fn chunk -> Enum.join(chunk) end)
      |> Enum.map(fn codon -> of_codon(codon) end)

    process_codons([], codons)
  end

  def process_codons(proteins, []) do
    proteinString =
      proteins
      |> Enum.reverse

    {:ok, proteinString}
  end

  def process_codons(_proteins, [{:error, _} | _other]) do
    { :error, "invalid RNA" }
  end

  def process_codons(proteins, [{:ok, "STOP"} | _other]) do
    process_codons(proteins, [])
  end

  def process_codons(proteins, [{:ok, protein} | other]) do
    process_codons([protein | proteins], other)
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: { atom, String.t() }
  def of_codon(codon) do
    codonLookup = %{
      "UGU" => "Cysteine",
      "UGC" => "Cysteine",
      "UUA" => "Leucine",
      "UUG" => "Leucine",
      "AUG" => "Methionine",
      "UUU" => "Phenylalanine",
      "UUC" => "Phenylalanine",
      "UCU" => "Serine",
      "UCC" => "Serine",
      "UCA" => "Serine",
      "UCG" => "Serine",
      "UGG" => "Tryptophan",
      "UAU" => "Tyrosine",
      "UAC" => "Tyrosine",
      "UAA" => "STOP",
      "UAG" => "STOP",
      "UGA" => "STOP"
    }

    protein = Map.get(codonLookup, codon)

    case protein do
      nil -> { :error, "invalid codon"}
      _ -> { :ok, protein }
    end
  end
end

