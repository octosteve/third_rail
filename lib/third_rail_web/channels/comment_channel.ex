defmodule ThirdRailWeb.CommentChannel do
  use ThirdRailWeb, :channel
  alias ThirdRailWeb.Endpoint

  @impl true
  def join("comment:issue:" <> issue_id, _payload, socket) do
    IO.inspect("Joining #{issue_id}")
    Endpoint.subscribe("comment:issue_id:#{issue_id}")
    {:ok, socket}
  end
end
