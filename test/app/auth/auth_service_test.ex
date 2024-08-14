defmodule App.AuthServiceTest do
  use AppWeb.ConnCase, async: true
  alias App.Auth.ApplicationService.AuthService

  @token "01914e21-ee46-74a4-b43c-c92acbc108ef@01914e22-1cf7-771a-892c-36bb1b52617f"

  test "With wrong token should return unauthorized" do
    assert AuthService.check("") === {:error, :unauthorized}
  end

  test "With nil should return unauthorized" do
    assert AuthService.check(nil) === {:error, :unauthorized}
  end

  test "With interger should return unauthorized" do
    assert AuthService.check(1) === {:error, :unauthorized}
  end

  test "With right token should return Authorized" do
    assert AuthService.check(@token) === {:ok, :authorized}
  end
end
