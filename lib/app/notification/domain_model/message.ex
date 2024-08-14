defmodule App.Notification.DomainModel.Message do
  use App, :domain_model
  alias App.Notification.DomainModel.Message
  alias App.Notification.DomainModel.Subscribe

  defstruct body: "", title: "", to: ""

  def create(body: body, title: title) when is_bitstring(body) and is_bitstring(title) do
    {:ok,
     %Message{
       body: body,
       title: title
     }}
  end

  def create(body: _body, title: _title),
    do: {:error, :invalid_data}

  def update_to(%Message{} = message, to: to) do
    {:ok,
     %Message{
       message
       | to: to
     }}
  end

  def update_to(_message, _to), do: {:error, :invalid_data}

  def create_chunk_message(%Message{} = message, [%Subscribe{} = _head | _tail] = subscribers) do
    {:ok,
     Enum.map(subscribers, fn subscribe ->
       %Message{
         message
         | to: subscribe.token
       }
     end)}
  end

  def create_chunk_message(_message, subscribers) when length(subscribers) == 0 do
    {:ok, []}
  end
end
