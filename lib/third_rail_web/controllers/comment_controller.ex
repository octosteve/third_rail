defmodule ThirdRailWeb.CommentController do
  use ThirdRailWeb, :controller

  alias ThirdRail.Core

  plug :can_handle_turbo_stream

  def index(conn, %{"issue_id" => issue_id}) do
    comments = Core.list_comments_for_issue(issue_id)
    render(conn, "index.html", comments: comments, layout: false)
  end

  def create(conn, %{"issue_id" => issue_id, "comment" => comment_params}) do
    case Core.create_comment_for_issue(issue_id, comment_params) do
      {:ok, comment} ->
        if Map.get(conn.assigns, :can_handle_turbo_stream) do
          conn
          |> put_resp_content_type("text/vnd.turbo-stream.html")
          |> render("comment.stream.html", comment: comment, layout: false)
        else
          conn
          |> put_flash(:info, "Comment Successfully created")
          |> redirect(to: Routes.issue_path(conn, :show, issue_id))
        end

      {:error, issue, %Ecto.Changeset{}} ->
        conn
        |> redirect(to: Routes.issue_path(conn, :show, issue))
    end
  end

  defp can_handle_turbo_stream(conn, _opts) do
    case conn |> get_req_header("accept") do
      [accept] ->
        if String.contains?(accept, "text/vnd.turbo-stream.html") do
          conn |> assign(:can_handle_turbo_stream, true)
        else
          conn
        end

      [] ->
        conn
    end
  end
end
