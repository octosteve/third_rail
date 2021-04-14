defmodule ThirdRailWeb.CommentController do
  use ThirdRailWeb, :controller

  alias ThirdRail.Core

  def index(conn, %{"issue_id" => issue_id}) do
    comments = Core.list_comments_for_issue(issue_id)
    render(conn, "index.html", comments: comments)
  end

  def create(conn, %{"issue_id" => issue_id, "comment" => comment_params}) do
    case Core.create_comment_for_issue(issue_id, comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment Successfully created")
        |> redirect(to: Routes.issue_path(conn, :show, issue_id))

      {:error, issue, %Ecto.Changeset{}} ->
        conn
        |> redirect(to: Routes.issue_path(conn, :show, issue))
    end
  end
end
