defmodule Discuss.OAuthUsers.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "oausers" do
    field :email, :string
    field :provider, :string
    field :token, :string
    has_many :topic, Discuss.Topics.Topic

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end
