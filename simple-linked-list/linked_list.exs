defmodule LinkedList do
  @opaque t :: tuple()

  defstruct head: nil, length: 0

  defmodule LinkedListEntry do
    @enforce_keys [:data]
    defstruct data: nil, next: nil
  end

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    %LinkedList{}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(%LinkedList{head: head, length: length}, elem) do
    new_head = %LinkedListEntry{data: elem, next: head}
    %LinkedList{head: new_head, length: length + 1}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(%LinkedList{length: length}) do
    length
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(%LinkedList{length: length}) do
    length === 0
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(%LinkedList{head: nil}) do
    {:error, :empty_list}
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(%LinkedList{head: %LinkedListEntry{data: data}}) do
    {:ok, data}
  end


  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(%LinkedList{head: nil}) do
    {:error, :empty_list}
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(%LinkedList{head: %LinkedListEntry{next: next} = head, length: length}) do
    case next do
      nil -> {:ok, LinkedList.new()}
      _ -> {:ok, %LinkedList{head: next, length: length - 1}}
    end
  end

  defp get_tail(%LinkedListEntry{next: nil} = tail) do
    nil
  end

  defp get_tail(%LinkedListEntry{next: next}) do
    next
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(list) do
    # Your implementation here...
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    # Your implementation here...
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    # Your implementation here...
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    # Your implementation here...
  end
end
