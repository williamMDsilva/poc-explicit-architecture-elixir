defmodule App.Notification.Repository.SubscribeRepository do
  alias App.Notification.DomainModel.Subscribe
  use App, :repository

  @take_fields [
    :token
  ]

  # token = Map.take(subscribe, @take_fields)
  def insert(%Subscribe{} = subscribe) do
    subscribe
    |> cast(%{}, @take_fields)
    |> Repo.insert()
  end
end
