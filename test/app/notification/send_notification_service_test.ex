defmodule App.Notification.SendNotificationServiceTest do
  use AppWeb.ConnCase, async: true
  import Ecto.Query

  alias App.Repo
  alias App.Notification.ApplicationService.SendNotificationService
  alias App.Notification.DomainModel.Subscribe

  @access_token "01914e21-ee46-74a4-b43c-c92acbc108ef@01914e22-1cf7-771a-892c-36bb1b52617f"

  # TODO - Add seed to crate a list of subscribers
  # TODO -

  test "With wrong token should return unauthorized" do
    data =
      SendNotificationService.send(
        "all",
        body: "you has been notified",
        title: "hey!",
        access_token: "asd@ads"
      )

    assert data === {:error, :unauthorized}
  end

  test "With right token and empty subscribers should :empty" do
    {:ok, data} =
      SendNotificationService.send(
        "all",
        body: "you has been notified",
        title: "hey!",
        access_token: @access_token
      )

    assert data == :empty
  end

  test "With push token and wrong token should return unauthorized" do
    data =
      SendNotificationService.send(
        "asdasd[123w123]",
        body: "you has been notified",
        title: "hey!",
        access_token: "asd@ads"
      )

    assert data === {:error, :unauthorized}
  end

  test "With push token and empty subscribers should :empty" do
    {:ok, data} =
      SendNotificationService.send(
        "asdasd[123w123]",
        body: "you has been notified",
        title: "hey!",
        access_token: @access_token
      )

    assert hd(data) |> is_map()
  end
end
