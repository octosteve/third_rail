defmodule ThirdRailWeb.CommentController do
  use ThirdRailWeb, :controller

  alias ThirdRail.Core

  plug :determine_layout

  def index(conn, %{"issue_id" => issue_id}) do
    comments = Core.list_comments_for_issue(issue_id)
    render(conn, "index.html", comments: comments, layout: false)
  end

  def create(conn, %{"issue_id" => issue_id, "comment" => comment_params}) do
    case Core.create_comment_for_issue(issue_id, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment Successfully created")
        |> redirect(to: Routes.issue_path(conn, :show, issue_id))

      {:error, issue, %Ecto.Changeset{}} ->
        conn
        |> redirect(to: Routes.issue_path(conn, :show, issue))
    end
  end

  defp determine_layout(conn, _opts) do
    if turbo_frame_request?(conn) do
      conn |> put_layout(false)
    else
      conn
    end
  end

  defp turbo_frame_request?(conn) do
    case get_req_header(conn, "turbo-frame") do
      [] -> false
      _header -> true
    end
  end
end
