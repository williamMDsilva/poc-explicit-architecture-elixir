defmodule App.Notification.DomainModel.TokenFormatPolicy do
  use App, :domain_model

  # TODO get real pattern from expo
  def pattern do
    ~r/^[[:alnum:]]+$/
  end
end
