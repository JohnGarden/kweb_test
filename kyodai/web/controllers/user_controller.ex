defmodule Kyodai.UserController do
    use Kyodai.Web, :controller
    alias Kyodai.User
    alias Kyodai.Repo

    plug :authenticate_user when action in [:index, :show]


    def index(conn, _params) do
        users = Repo.all(Kyodai.User)
        render conn, "index.html", users: users
    end


    def show(conn, %{"id" => id}) do
        user = Repo.get(User, id)
        render conn, "show.html", user: user
    end

    def new(conn, _params) do
        changeset = User.changeset(%User{})
        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"user" => user_params}) do
        changeset = User.registration_changeset(%User{}, user_params)
        case Repo.insert(changeset) do
          {:ok, user} ->
            conn
            |> Kyodai.Auth.login(user)
            |> put_flash(:info, "#{user.name} created!")
            |> redirect(to: user_path(conn, :index))
          {:error, changeset} ->
            render(conn, "new.html", changeset: changeset)
        end
    end

    defp authenticate(conn, _opts) do
        if conn.assigns.current_user do
          conn
        else
          conn
          |> put_flash(:error, "You must be logged in to access that page")
          |> redirect(to: page_path(conn, :index))
          |> halt()
        end
    end
end


# res = for s <- map do 
#     case id do
#         nil -> id = s
#         _ -> id = 123
#     end
# end

# map = Enum.reduce [1, 2, 3], %{}, fn x, acc ->
#   Map.put(acc, x, x)
# end