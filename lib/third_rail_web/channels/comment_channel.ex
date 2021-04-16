defmodule ThirdRailWeb.CommentChannel do
  use ThirdRailWeb, :channel
  alias ThirdRail.Core
  intercept ["new_comment"]

  @impl true
  def join("comment:issue:" <> _issue_id, _payload, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_out("new_comment", %{id: id}, socket) do
    comment = Core.get_comment!(id)

    push(socket, "new_comment", %{
      body:
        Phoenix.View.render_to_string(ThirdRailWeb.CommentView, "comment.stream.html",
          comment: comment
        )
    })

    {:noreply, socket}
  end
end
