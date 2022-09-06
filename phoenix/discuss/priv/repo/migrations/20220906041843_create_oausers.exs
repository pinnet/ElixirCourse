defmodule Discuss.Repo.Migrations.CreateOausers do
  use Ecto.Migration

  def change do
    create table(:oausers) do
      add :email, :string
      add :provider, :string
      add :token, :string

      timestamps()
    end
  end
end
