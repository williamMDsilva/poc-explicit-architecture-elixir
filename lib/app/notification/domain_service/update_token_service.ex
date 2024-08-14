defmodule App.Notification.DomainModel.UpdateTokenService do
  use App, :domain_service
  alias App.Notification.DomainModel.{Subscribe, TokenFormatPolicy}

  def update_token(%Subscribe{} = user, token: token) do
    case String.match?(token, TokenFormatPolicy.pattern()) do
      true ->
        {:ok, Subscribe.update_token(user, token: token)}

      false ->
        {:error, :error_format_token_policy}
    end
  end
end
