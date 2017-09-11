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

  def transform(word, { _body, :vowel, _priority}) do
    word <> "ay"
  end

  def transform(word, { body, :consonant, _priority}) do
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
      |> Enum.sort(fn ({_, _, priority: value1}, {_, _, priority: value2}) -> value1 >= value2 end)
  end

  defp get_pig_latin_rules() do
    [
      # consonants
      { "b", :consonant, priority: 1},
      { "c", :consonant, priority: 1},
      { "d", :consonant, priority: 1},
      { "f", :consonant, priority: 1},
      { "g", :consonant, priority: 1},
      { "h", :consonant, priority: 1},
      { "j", :consonant, priority: 1},
      { "k", :consonant, priority: 1},
      { "l", :consonant, priority: 1},
      { "m", :consonant, priority: 1},
      { "n", :consonant, priority: 1},
      { "p", :consonant, priority: 1},
      { "q", :consonant, priority: 1},
      { "r", :consonant, priority: 1},
      { "s", :consonant, priority: 1},
      { "t", :consonant, priority: 1},
      { "v", :consonant, priority: 1},
      { "x", :consonant, priority: 1},
      { "z", :consonant, priority: 1},
      { "w", :consonant, priority: 1},
      { "y", :consonant, priority: 1},
      # vowels
      { "a", :vowel, priority: 1},
      { "e", :vowel, priority: 1},
      { "i", :vowel, priority: 1},
      { "o", :vowel, priority: 1},
      { "u", :vowel, priority: 1},
      # consonant groups
      { "ch", :consonant, priority: 10},
      { "qu", :consonant, priority: 10},
      { "squ", :consonant, priority: 10},
      { "th", :consonant, priority: 10},
      { "thr", :consonant, priority: 10},
      { "sch", :consonant, priority: 10},
      # vowels groups
      { "yt", :vowel, priority: 100},
      { "xr", :vowel, priority: 100}
    ]
  end
end

