defmodule App.Notification.ApplicationService.SendNotificationService do
  use App, :application_service
  alias App.Auth.ApplicationService.AuthService
  alias App.Notification.Repository.SubscribeRepository
  alias App.Notification.DomainModel.Message

  @field [
    :to,
    :body,
    :title
  ]

  defp send_to_expo([%Message{} = _head | _tail] = chunk) when is_list(chunk) do
    message_list = Enum.map(chunk, fn it -> Map.take(it, @field) end)

    ExponentServerSdk.PushNotification.push_list(message_list)
  end

  defp send_to_expo(chunk) when length(chunk) == 0, do: {:ok, :empty}
  defp send_to_expo(_chunk), do: {:error, :internal_server_error}

  def send("all", body: body, title: title, access_token: access_token) do
    message = Message.create(body: body, title: title)

    with {:ok, _authorized} <- AuthService.check(access_token),
         {:ok, subscribers} <- SubscribeRepository.fetch_subscribers(),
         {:ok, messages_chunk} <- Message.create_chunk_message(message, subscribers),
         {ok, response} <- send_to_expo(messages_chunk) do
      {:ok, response}
    else
      {:error, error} -> {:error, error}
    end
  end

  def send(push_token, body: body, title: title, access_token: access_token) do
    message = Message.create(body: body, title: title) |> Message.update_to(to: push_token)

    with {:ok, _authorized} <- AuthService.check(access_token),
         {ok, response} <- send_to_expo([message]) do
      {:ok, response}
    else
      {:error, error} -> {:error, error}
    end
  end
end
