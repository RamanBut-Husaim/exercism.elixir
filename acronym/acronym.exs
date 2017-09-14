defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> get_words
    |> Enum.map(&get_first_letter/1)
    |> Enum.join
    |> String.upcase
  end

  defp get_words(string) do
    string
    |> String.replace(~r/([^\w-]|_)+/u, " ")
    |> String.split
  end

  def get_first_letter(word) do
    downcase = String.downcase(word)

    case String.equivalent?(downcase, word) do
      true -> String.first(word)
      _ -> word
          |> String.graphemes
          |> Enum.filter(&is_uppercase/1)
          |> Enum.join
    end
  end

  defp is_uppercase(grapheme) do
    uppercase = String.upcase(grapheme)

    String.equivalent?(grapheme, uppercase) && String.match?(grapheme, ~r/\p{L}/)
  end
end
