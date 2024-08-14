defmodule App.Notification.Repository.SubscribeRepository do
  use App, :repository
  alias App.Notification.DomainModel.Subscribe
  import Ecto.Query

  @take_fields [
    :token
  ]

  # token = Map.take(subscribe, @take_fields)
  def insert(%Subscribe{} = subscribe) do
    subscribe
    |> cast(%{}, @take_fields)
    |> Repo.insert()
  end

  def fetch_subscribers() do
    case Subscribe
         |> Repo.all() do
      [%App.Notification.DomainModel.Subscribe{} = _head | _tail] = subscribers ->
        {:ok, subscribers}

      [] ->
        {:ok, []}

      _ ->
        {:ok, []}
    end
  end
end
