defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    get_verse_prefix(number) <> get_gift_postfix(number)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
  end

  defp get_numeral_for(number) do
    numeralLookup = %{
      1 => "first",
      2 => "second",
      3 => "third",
      4 => "fourth",
      5 => "fifth",
      6 => "sixth",
      7 => "seventh",
      8 => "eighth",
      9 => "ninth",
      10 => "tenth",
      11 => "eleventh",
      12 => "twelfth"
    }

    Map.get(numeralLookup, number)
  end

  defp get_gift_for(number) do
    giftLookup = %{
      1 => "a Partridge in a Pear Tree",
      2 => "two Turtle Doves",
      3 => "three French Hens",
      4 => "four Calling Birds",
      5 => "five Gold Rings",
      6 => "six Geese-a-Laying",
      7 => "seven Swans-a-Swimming",
      8 => "eight Maids-a-Milking",
      9 => "nine Ladies Dancing",
      10 => "ten Lords-a-Leaping",
      11 => "eleven Pipers Piping",
      12 => "twelve Drummers Drumming"
    }

    Map.get(giftLookup, number)
  end

  defp get_verse_prefix(number) do
    numeral = get_numeral_for(number)
    "On the #{numeral} day of Christmas my true love gave to me"
  end

  defp get_gift_postfix(number) do
    get_gift_postfix("", number)
  end

  defp get_gift_postfix("", 1) do
    gift = get_gift_for(1)
    ", " <> gift <> "."
  end

  defp get_gift_postfix(postfix, 1) do
    gift = get_gift_for(1)
    postfix <> "," <> " and " <> gift <> "."
  end

  defp get_gift_postfix(postfix, verse) do
    gift = get_gift_for(verse)
    get_gift_postfix(postfix <> ", " <> gift, verse - 1)
  end
end

