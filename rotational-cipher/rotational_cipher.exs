defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    alphabetLookup =
      alphabet
      |> String.graphemes
      |> MapSet.new

    rotate([], text |> String.graphemes, shift, alphabet, alphabetLookup)
  end

  defp rotate(result, [], _shift, _alphabet, _alphabetLookup) do
    result
    |> Enum.reverse
    |> Enum.join
  end

  defp rotate(result, [letter | other], shift, alphabet, alphabetLookup) do
    transformedLetter = transform(letter, shift, alphabet, alphabetLookup)

    rotate([transformedLetter | result], other, shift, alphabet, alphabetLookup)
  end

  defp transform(letter, shift, alphabet, alphabetLookup) do
    lowercase = String.downcase(letter)
    case MapSet.member?(alphabetLookup, lowercase) do
      true -> transform(letter, shift, alphabet)
      _ -> letter
    end
  end

  defp transform(letter, shift, alphabet) do
    shifted = shift_letter(letter, shift, alphabet)
    case is_lowercase(letter) do
      true -> shifted
      _ -> String.upcase(shifted)
    end
  end

  defp shift_letter(letter, shift, alphabet) do
    lowercase = String.downcase(letter)

    index = get_index(alphabet, lowercase)

    newIndex = rem(index + shift, String.length(alphabet))

    String.at(alphabet, newIndex)
  end

  defp is_lowercase(letter) do
    letter
    |> String.downcase
    |> String.equivalent?(letter)
  end

  defp get_index(alphabet, letter) do
    case String.split(alphabet, letter, parts: 2) do
      [head, _] -> String.length(head)
      [_] -> {:error, "no value has been found"}
    end
  end
end

