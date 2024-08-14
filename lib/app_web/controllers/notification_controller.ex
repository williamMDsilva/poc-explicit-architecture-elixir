defmodule AppWeb.NotificationController do
  use Phoenix.Controller
  import Plug.Conn
  alias App.Notification.ApplicationService.SubscribeService

  @api_key_header "access_token"

  defp get_token_from_header(conn) do
    case get_req_header(conn, @api_key_header) do
      [val | _] -> val
      _ -> nil
    end
  end

  def subscribe(conn, %{"token" => token}) do
    access_token = get_token_from_header(conn)

    dbg(access_token)

    case SubscribeService.subscribe(token: token, access_token: access_token) do
      {:ok, subscribe} ->
        conn
        |> put_status(:created)
        |> json(%{id: subscribe.id})

      {:error, :unauthorized} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "unauthorized", message: "Unauthorized"})

      _ ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "error_server", message: "Something went wrong!"})
    end
  end

  def subscribe(conn, _) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "invalid_data", message: "token provided"})
  end
end
