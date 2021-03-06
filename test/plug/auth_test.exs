defmodule Rumbl.AuthTest do
  use Rumbl.ConnCase
  alias Rumbl.Auth

  setup %{ conn: conn } do
  	conn =
  	conn
  	|> bypass_through(Rumbl.Router, :browser)
  	|> get("/videos")
  	{ :ok, %{ conn: conn } }
  end

  test "Authenticate_user halts when no current_user exists", %{ conn: conn } do
    plugged_connection = Auth.authenticate_user(conn, [])
    assert plugged_connection.halted
  end

  test "authenticate_user continues when the current_user exists", %{ conn: conn } do
		conn =
		conn
		|> assign(:current_user, %Rumbl.User{})
		|> Auth.authenticate_user([])
		refute conn.halted
	end

	test "login puts the user in the session", %{ conn: conn } do
		login_conn =
		conn
		|> Auth.login(%Rumbl.User{ id: 123 })
		|> send_resp(:ok, " ")
		next_conn = get(login_conn, "/")
		assert get_session(next_conn, :user_id) == 123
	end

	test "logout drops the session", %{ conn: conn } do
		logout_conn =
		conn
		|> Auth.login(%Rumbl.User{ id: 123 })
		|> Auth.logout()
		|> send_resp(:ok, "")
		next_conn = get(logout_conn, "/")
		refute get_session(next_conn, :user_id) == 123
	end

	test "call places user from session into assigns", %{ conn: conn } do
		user = insert_user(name: "other", username: "other")
		conn =
		conn
		|> put_session(:user_id, user.id)
		|> Auth.call(Repo)
		assert conn.assigns.current_user.id == user.id
	end

	test "call with no session sets current_user assign to nil", %{ conn: conn } do
		conn = Auth.call(conn, Repo)
		assert conn.assigns.current_user == nil
	end

	test "login with a valid username and pass", %{ conn: conn } do
		user = insert_user(name: "me", username: "me", password: "password")
		{ :ok, conn } =
		Auth.authenticate_by_name_and_password(conn, "me", "password", repo: Repo)
		assert conn.assigns.current_user.id == user.id
	end

	test "login with a not fount user", %{ conn: conn } do
		assert { :error, :not_found, _conn } =
		Auth.authenticate_by_name_and_password(conn, "me", "password", repo: Repo)
	end

	test "login with password missmatch", %{ conn: conn } do
		user = insert_user(name: "me", username: "me", password: "password")
		assert { :error, :unauthorized, _conn } =
		Auth.authenticate_by_name_and_password(conn, "me", "wrong", repo: Repo)
	end
end
