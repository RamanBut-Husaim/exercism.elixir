defmodule LinkedList do
  defstruct head: nil, length: 0

  defmodule LinkedListEntry do
    @enforce_keys [:data]
    defstruct data: nil, next: nil
  end

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: %LinkedList{}
  def new() do
    %LinkedList{}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(%LinkedList{}, any()) :: %LinkedList{}
  def push(%LinkedList{head: head, length: length}, elem) do
    new_head = %LinkedListEntry{data: elem, next: head}
    %LinkedList{head: new_head, length: length + 1}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(%LinkedList{}) :: non_neg_integer()
  def length(%LinkedList{length: length}) do
    length
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(%LinkedList{}) :: boolean()
  def empty?(%LinkedList{length: length}) do
    length === 0
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(%LinkedList{}) :: {:ok, any()} | {:error, :empty_list}
  def peek(%LinkedList{head: nil}) do
    {:error, :empty_list}
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(%LinkedList{}) :: {:ok, any()} | {:error, :empty_list}
  def peek(%LinkedList{head: %LinkedListEntry{data: data}}) do
    {:ok, data}
  end


  @doc """
  Get tail of a LinkedList
  """
  @spec tail(%LinkedList{}) :: {:ok, %LinkedList{}} | {:error, :empty_list}
  def tail(%LinkedList{head: nil}) do
    {:error, :empty_list}
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(%LinkedList{}) :: {:ok, %LinkedList{}} | {:error, :empty_list}
  def tail(%LinkedList{head: %LinkedListEntry{next: next}, length: length}) do
    case next do
      nil -> {:ok, LinkedList.new()}
      _ -> {:ok, %LinkedList{head: next, length: length - 1}}
    end
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(%LinkedList{}) :: {:ok, any(), %LinkedList{}} | {:error, :empty_list}
  def pop(%LinkedList{head: nil}) do
    {:error, :empty_list}
  end

  def pop(%LinkedList{head: %LinkedListEntry{data: data}} = list) do
    {:ok, tail} = LinkedList.tail(list)
    {:ok, data, tail}
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: %LinkedList{}
  def from_list(list) do
    list
    |> Enum.reverse
    |> Enum.reduce(LinkedList.new(), fn(x, acc) -> LinkedList.push(acc, x) end)
  end

  defp from_list([], list) do
    list
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(%LinkedList{}) :: list()
  def to_list(%LinkedList{head: head}) do
    to_list(head, [])
  end

  defp to_list(nil, list) do
    Enum.reverse(list)
  end

  defp to_list(%LinkedListEntry{next: next, data: data}, list) do
    to_list(next, [data | list])
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(%LinkedList{}) :: %LinkedList{}
  def reverse(list) do
    list
    |> LinkedList.to_list
    |> Enum.reverse
    |> LinkedList.from_list
  end
end
