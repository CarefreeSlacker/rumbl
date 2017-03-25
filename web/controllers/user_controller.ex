defmodule Rumbl.UserController do
  use Rumbl.Web, :controller
  alias Rumbl.User
  alias Rumbl.Repo

  plug :action

  def new(conn, _params) do
  	changeset = User.changeset(%User{})
  	render conn, "new.html" , changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
		changeset = User.changeset(%User{}, user_params)
		try do
			user = Repo.insert(changeset)
			conn
			|> put_flash(:info , "#{user.name }  created!" )
			|> redirect(to: user_path(conn, :index))
		rescue
			Postgrex.Error -> render conn, "new.html", changeset: changeset
		end
  end

  def index(conn, _params) do
    users = Rumbl.Repo.all(Rumbl.User)
    render conn, "index.html", users: users
  end

  def show(conn, %{ "id" => id}) do
    user = Rumbl.Repo.get(Rumbl.User, id)
		render conn, "show.html", user: user
  end
end
