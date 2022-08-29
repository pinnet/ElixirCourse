defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 52 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 52
  end

  test "shuffle deck randomizes deck" do
    deck = Cards.create_deck
    shuffled_deck = Cards.shuffle(deck)
    assert length(shuffled_deck) == 52
    refute deck == shuffled_deck
  end

  test "create_hand should create a new deck, shuffle and deal a hand of cards and returns the remaing cards" do
    {hand, deck} = Cards.create_hand(:rand.uniform(51))
    assert length(hand) + length(deck) == 52
  end

end
