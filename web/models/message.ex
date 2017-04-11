defmodule Rumbl.Message do
  use Rumbl.Web, :model

  schema "messages" do
    field :text, :string
    belongs_to :user, Rumbl.User
    belongs_to :room, Rumbl.Room

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text])
    |> validate_required([:text])
  end
end
