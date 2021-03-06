defmodule RafiyolWeb.SessionController do
  use RafiyolWeb, :controller

  plug RafiyolWeb.Logged, :notlogged when action in [:new]
  plug RafiyolWeb.Logged, :logged when action in [:delete]


  def new(conn, _params) do
    render(conn, "new.html", page_name: "Registration")
  end

  def create(conn, %{"user" => %{"username" => username, "password" => password}}) do
    case Rafiyol.get_user_by_username_and_password(username, password) do
      %Rafiyol.User{} = user ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Successfully logged in")
        |> redirect(to: Routes.user_path(conn, :show, user))

      _ ->
        conn
        |> put_flash(:error, "This username and password combination cannot be found")
        |> render("new.html", page_name: "Registration")
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> configure_session(drop: true)
    |> put_flash(:info, "Successfully logged out")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
