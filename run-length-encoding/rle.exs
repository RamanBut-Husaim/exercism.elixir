defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    encoded = encode([], 0, String.graphemes(string))
    to_string("", encoded)
  end

  defp encode(encoded, _counter, []) do
    Enum.reverse(encoded)
  end

  defp encode(encoded, 0, [ a ]) do
    encode([{a, 1} | encoded], 0, [])
  end

  defp encode(encoded, counter, [ a ]) do
    encode([{a, counter + 1} | encoded], 0, [])
  end

  defp encode(encoded, counter, [a | [a | other]]) do
    encode(encoded, counter + 1, [a | other])
  end

  defp encode(encoded, counter, [a | [b | other]]) do
    encode([{a, counter + 1} | encoded], 0, [b | other])
  end

  defp to_string(encoded_string, []) do
    encoded_string
  end

  defp to_string(encoded_string, [{a, 1} | other]) do
    to_string(encoded_string <> a, other)
  end

  defp to_string(encoded_string, [{a, counter} | other]) do
    to_string(encoded_string <> Integer.to_string(counter) <> a, other)
  end

  @spec decode(String.t) :: String.t
  def decode(string) do

  end
end
