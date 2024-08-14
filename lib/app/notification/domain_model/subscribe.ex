defmodule App.Notification.DomainModel.Subscribe do
  use App, :domain_model

  # TODO - subscrition could be a better name then subscribe
  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "subscribe" do
    field :token, :string
    timestamps()
  end

  def create(token: token) when is_bitstring(token) do
    %@self{
      token: token
    }
  end

  def update_token(%@self{} = user, token: token) when is_bitstring(token) do
    %@self{
      user
      | token: token
    }
  end
end
