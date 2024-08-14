defmodule App.Repo.Migrations.CreateSubscribe do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS pgcrypto"

    create table(:subscribe, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false, default: fragment("gen_random_uuid()")
      add :token, :string
      timestamps()
    end
  end
end
