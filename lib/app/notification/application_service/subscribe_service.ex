defmodule App.Notification.ApplicationService.SubscribeService do
  alias App.Notification.Repository.SubscribeRepository
  alias App.Auth.ApplicationService.AuthService
  use App, :application_service

  alias App.Notification.DomainModel.Subscribe

  def subscribe(token: token, access_token: access_token) do
    subscribe_model = Subscribe.create(token: token)

    with {:ok, _authorized} <- AuthService.check(access_token),
         {:ok, subscribe} <- SubscribeRepository.insert(subscribe_model) do
      {:ok, subscribe}
    else
      {:error, error} -> {:error, error}
    end
  end
end
