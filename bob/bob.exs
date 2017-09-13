defmodule Bob do
  def hey(statement) do
    operations = [&process_ask/1, &process_silence/1, &process_yell/1, &process_other/1]

    process(operations, statement)
  end

  defp process([operation | other], statement) do
    case operation.(statement) do
      {:ok, answer} -> answer
      _ -> process(other, statement)
    end
  end

  defp process_silence(statement) do
    case silence?(statement) do
      true -> { :ok, "Fine. Be that way!" }
      false -> { :error }
    end
  end

  defp silence?(statement) do
    statement
    |> String.trim
    |> String.length
    |> Kernel.== (0)
  end

  defp process_ask(statement) do
    case ask?(statement) do
      true -> { :ok, "Sure." }
      false -> { :error }
    end
  end

  defp ask?(statement) do
    String.ends_with?(statement, "?")
  end

  defp process_yell(statement) do
    case yell?(statement) do
      true -> { :ok, "Whoa, chill out!" }
      false -> { :error }
    end
  end

  defp yell?(statement) do
    capitalized = String.upcase(statement)

    String.equivalent?(statement, capitalized) && Regex.match?(~r/\p{L}+/, statement)
  end

  defp process_other(_statement) do
    { :ok, "Whatever." }
  end
end
