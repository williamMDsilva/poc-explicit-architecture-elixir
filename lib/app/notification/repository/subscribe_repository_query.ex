defmodule App.Notification.Repository.SubscribeRepositoryQuery do
  use App, :repository
  alias App.Notification.DomainModel.Subscribe
  import App.Notification.Repository.Mapper.MapperDomain
  import Ecto.Query

  #   import Ecto.Query
  # query =
  #   from s in App.Notification.DomainModel.Subscribe,
  #     select: s
  # subscribers = Repo.all(query)
  # {:ok, subscribers}

  @take_fields [
    :token
  ]

  def insert(%Subscribe{} = subscribe) do
    fields = Map.take(subscribe, @take_fields)
    Repo.insert_all(Subscribe, [fields])
  end

  def fetch_subscribers() do
    from(
      q in Subscribe,
      select: map(q, ^@take_fields)
    )
    |> Repo.all()
    |> MapperDomain.exec()
  end
end
