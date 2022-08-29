defmodule Cards do
  @moduledoc """
    Provides methods for creating and handeling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of cards
  """
  def create_deck do
    values = ["Ace","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Jack","Queen","King"]
    suits  = ["Spades","Hearts","Clubs","Diamonds"]
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Returns a list of strings representing a shuffeled `deck` of cards
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end
  @doc """
    Returns a true or false if a `deck` contains a certain `card`


  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end
  @doc """
    Returns a tuple containing list of strings representing a hand
    of `hand_size` of cards and the remaining `deck` of cards

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end
  @doc """
    Saves a list of strings representing a `deck` of cards to the `filename`
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end
  @doc """
    Returns a list of strings representing a deck of cards
    loaded from a file with `filename` or an will generate an error
  """
  def load(filename) do
    case File.read(filename) do
      {:ok,binary} -> :erlang.binary_to_term(binary)
      {:error,_reason} -> "File not found - #{filename}"
    end
  end
  @doc """
    Returns a tuple that contains a list of strings representing
    a `hand_size` of cards and the remaining cards from a new deck
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
