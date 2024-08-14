defmodule AppWeb.NotificationController do
  use Phoenix.Controller
  import Plug.Conn
  alias App.Notification.ApplicationService.SubscribeService
  alias App.Notification.ApplicationService.SendNotificationService

  @api_key_header "access_token"

  # TODO - create a Helper to handle returns

  defp get_token_from_header(conn) do
    case get_req_header(conn, @api_key_header) do
      [val | _] -> val
      _ -> nil
    end
  end

  def send(conn, %{"body" => body, "title" => title, "push_token" => push_token}) do
    access_token = get_token_from_header(conn)

    case SendNotificationService.send(
           push_token,
           body: body,
           title: title,
           access_token: access_token
         ) do
      {:ok, reponse} ->
        conn
        |> put_status(:ok)
        |> json(%{reponse: reponse})

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

  def subscribe(conn, %{"token" => token}) do
    access_token = get_token_from_header(conn)

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
