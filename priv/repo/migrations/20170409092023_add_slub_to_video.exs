defmodule Rumbl.Repo.Migrations.AddSlubToVideo do
  use Ecto.Migration

  def change do
		alter table(:videos) do
			add :slug, :string
		end
  end
end
