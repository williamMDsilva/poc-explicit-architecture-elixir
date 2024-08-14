defmodule App.Auth.ApplicationService.AuthService do
  use App, :application_service

  @pair {"01914e21-ee46-74a4-b43c-c92acbc108ef", "01914e22-1cf7-771a-892c-36bb1b52617f"}

  # TODO - transform this service in real auth with jwt
  def check(access_token) when is_bitstring(access_token) do
    {right_one, right_two} = @pair

    [one, two] = String.split(access_token, "@")

    case right_one == one and right_two == two do
      true -> {:ok, :authorized}
      false -> {:error, :unauthorized}
    end
  end
end
