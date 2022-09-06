defmodule Discuss.OAuthUsersTest do
  use Discuss.DataCase

  alias Discuss.OAuthUsers

  describe "oausers" do
    alias Discuss.OAuthUsers.User

    import Discuss.OAuthUsersFixtures

    @invalid_attrs %{email: nil, provider: nil, token: nil}

    test "list_oausers/0 returns all oausers" do
      user = user_fixture()
      assert OAuthUsers.list_oausers() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert OAuthUsers.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", provider: "some provider", token: "some token"}

      assert {:ok, %User{} = user} = OAuthUsers.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.provider == "some provider"
      assert user.token == "some token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OAuthUsers.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", provider: "some updated provider", token: "some updated token"}

      assert {:ok, %User{} = user} = OAuthUsers.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.provider == "some updated provider"
      assert user.token == "some updated token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = OAuthUsers.update_user(user, @invalid_attrs)
      assert user == OAuthUsers.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = OAuthUsers.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> OAuthUsers.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = OAuthUsers.change_user(user)
    end
  end
end
