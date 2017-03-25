defmodule Rumbl.Repo.Migrations.AddUsernameUniquenes do
  use Ecto.Migration

  def change do
  	create index(:users , [:username], unique: true)
  	create index(:users , [:name], unique: true)
  end
end
