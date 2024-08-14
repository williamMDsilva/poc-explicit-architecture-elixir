defmodule App.Notification.SubscribeServiceTest do
  use AppWeb.ConnCase, async: true
  import Ecto.Query

  alias App.Repo
  alias App.Notification.ApplicationService.SubscribeService
  alias App.Notification.DomainModel.Subscribe

  @access_token "01914e21-ee46-74a4-b43c-c92acbc108ef@01914e22-1cf7-771a-892c-36bb1b52617f"
  @token "asdaw1234123[asdasq123]"

  test "With wrong token should return unauthorized" do
    data = SubscribeService.subscribe(token: "", access_token: "")
    assert data === {:error, :unauthorized}
  end

  test "With right token should return new entity" do
    {:ok, data} =
      SubscribeService.subscribe(
        token: @token,
        access_token: @access_token
      )

    subscribe =
      Subscribe
      |> where(id: ^data.id)
      |> Repo.one()

    assert subscribe.token === @token
  end
end
