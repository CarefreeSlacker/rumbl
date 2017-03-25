defmodule Rumbl.SessionController do
  use Rumbl.Web, :controller

  def new(conn, _params) do
  	render conn, "new.html"
  end

  def create(conn, %{ "session" => %{ "name" => user, "password" => password } }) do
		case Rumbl.Auth.authenticate_by_name_and_password(conn, user, password, repo: Rumbl.Repo) do
			{ :ok, conn } ->
				conn
				|> put_flash(:info, "Welcome back")
				|> redirect(to: page_path(conn, :index))
			{ :error, _reason, conn } ->
				conn
				|> put_flash(:error, "Invalid username/password")
				|> render("new.html")
		end
  end

  def delete(conn, _) do
  	conn
  	|> Rumbl.Auth.logout
  	|> redirect(to: page_path(conn, :index))
  end
end
