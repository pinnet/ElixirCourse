defmodule Discuss.OAuthUsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Discuss.OAuthUsers` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        provider: "some provider",
        token: "some token"
      })
      |> Discuss.OAuthUsers.create_user()

    user
  end
end
