defmodule DiscussWeb.OAuthController do
  use DiscussWeb, :controller
  plug Ueberauth
  alias DiscussWeb.Router.Helpers, as: Routes
  alias Discuss.OAuthUsers

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn,%{"provider" => provider} = _params) do

    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: provider}

    signin(conn, user_params)
  end

  defp signin(conn,params) do
    case insert_or_update(params) do
      {:ok, user} ->
          conn
            |> put_flash(:info,"Login successful")
            |> put_session(:user_id, user.id)
            |> redirect(to: Routes.topic_path(conn, :index))

      {:error, _reason} ->
          conn
            |> put_flash(:error,"Sign-in error")
            |> redirect(to: Routes.topic_path(conn, :index))
    end
  end

  defp insert_or_update(params) do
    case OAuthUsers.get_user_by_email(params.email) do
      nil ->
        OAuthUsers.create_user(params)
      user ->
        {:ok, user}
    end
  end


end
