defmodule App.Notification.Repository.Mapper.MapperDomain do
  alias App.Notification.DomainModel.Subscribe

  defp exec([%Subscribe{} = _head | _tail] = subscribers) do
    {:ok, subscribers}
  end

  defp exec([]) do
    {:ok, []}
  end

  defp exec(_) do
    {:ok, []}
  end
end
