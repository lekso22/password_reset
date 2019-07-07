defmodule PasswordReset.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password, :string
      add :reset_token, :string
      add :token_generated, :naive_datetime
    
    end
    create unique_index(:users, [:email])
    create unique_index(:users, [:reset_token])

  end
end
