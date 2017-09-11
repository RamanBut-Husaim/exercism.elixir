defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    prioritizedRules = get_prioritized_rules()

    String.split(phrase)
    |> Enum.map(fn word -> translate_word(word, prioritizedRules) end)
    |> Enum.join(" ")
  end

  defp translate_word(_word, []) do
    {:error, "could not perform transformation"}
  end

  defp translate_word(word, [rule | otherRules]) do
    case satisfies_rule?(word, rule) do
      true -> transform(word, rule)
      _ -> translate_word(word, otherRules)
    end
  end

  defp satisfies_rule?(word, { body, _, _}) do
    String.starts_with?(word, body)
  end

  def transform(word, { _body, :vowel, _properties}) do
    word <> "ay"
  end

  def transform(word, { body, :consonant, _properties}) do
    prefix = get_consonant_prefix(word, body)
    transform_consonant(word, prefix)
  end

  def transform_consonant(word, prefix) do
    [_ , segment] = String.split(word, prefix, parts: 2)

    segment <> prefix <> "ay"
  end

  def get_consonant_prefix(word, ruleBody) do
    vowels =
      get_prioritized_rules()
      |> Enum.filter(fn ({_, type, _}) -> type === :vowel end)
      |> Enum.map(fn ({b, _, _}) -> b end)

    [_ , headlessWord] = String.split(word, ruleBody, parts: 2)
    [prefix , _] = String.split(headlessWord, vowels, parts: 2)
    ruleBody <> prefix
  end

  defp get_prioritized_rules() do
      get_pig_latin_rules()
      |> Enum.sort(fn ({_, _, props1}, {_, _, props2}) -> compare_properties_by_priority(props1, props2) end)
  end

  defp compare_properties_by_priority([{_, priority1} | _], [{_, priority2} | _]) do
    priority1 >= priority2
  end

  defp get_pig_latin_rules() do
    [
      # consonants
      { "b", :consonant, [priority: 1, prolongable: true]},
      { "c", :consonant, [priority: 1, prolongable: true]},
      { "d", :consonant, [priority: 1, prolongable: true]},
      { "f", :consonant, [priority: 1, prolongable: true]},
      { "g", :consonant, [priority: 1, prolongable: true]},
      { "h", :consonant, [priority: 1, prolongable: true]},
      { "j", :consonant, [priority: 1, prolongable: true]},
      { "k", :consonant, [priority: 1, prolongable: true]},
      { "l", :consonant, [priority: 1, prolongable: true]},
      { "m", :consonant, [priority: 1, prolongable: true]},
      { "n", :consonant, [priority: 1, prolongable: true]},
      { "p", :consonant, [priority: 1, prolongable: true]},
      { "q", :consonant, [priority: 1, prolongable: true]},
      { "r", :consonant, [priority: 1, prolongable: true]},
      { "s", :consonant, [priority: 1, prolongable: true]},
      { "t", :consonant, [priority: 1, prolongable: true]},
      { "v", :consonant, [priority: 1, prolongable: true]},
      { "x", :consonant, [priority: 1, prolongable: true]},
      { "z", :consonant, [priority: 1, prolongable: true]},
      { "w", :consonant, [priority: 1, prolongable: true]},
      { "y", :consonant, [priority: 1, prolongable: true]},
      # vowels
      { "a", :vowel, [priority: 1, prolongable: false]},
      { "e", :vowel, [priority: 1, prolongable: false]},
      { "i", :vowel, [priority: 1, prolongable: false]},
      { "o", :vowel, [priority: 1, prolongable: false]},
      { "u", :vowel, [priority: 1, prolongable: false]},
      # consonant groups
      { "ch", :consonant, [priority: 10, prolongable: false]},
      { "qu", :consonant, [priority: 10, prolongable: false]},
      { "squ", :consonant, [priority: 10, prolongable: false]},
      { "th", :consonant, [priority: 10, prolongable: false]},
      { "thr", :consonant, [priority: 10, prolongable: false]},
      { "sch", :consonant, [priority: 10, prolongable: false]},
      # vowels groups
      { "yt", :vowel, [priority: 100, prolongable: false]},
      { "xr", :vowel, [priority: 100, prolongable: false]}
    ]
  end
end

