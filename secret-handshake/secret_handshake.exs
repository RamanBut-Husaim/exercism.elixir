defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    actionCodes = [{1, "wink"}, {2, "double blink"}, {4, "close your eyes"}, {8, "jump"}]

    actions = commands(code, [], actionCodes)

    case should_include_action(code, {16, "something"}) do
      true -> Enum.reverse(actions)
      _ -> actions
    end
  end

  defp commands(_code, actions, []) do
    Enum.reverse(actions)
  end

  defp commands(code, actions, [{_, actionText} = action | otherActions]) do
    case should_include_action(code, action) do
      true -> commands(code, [actionText | actions], otherActions)
      _ -> commands(code, actions, otherActions)
    end
  end

  defp should_include_action(code, {bit, _}) do
    (code &&& bit) === bit
  end
end

