defmodule ThirdRailWeb.IssueController do
  use ThirdRailWeb, :controller

  alias ThirdRail.Core
  alias ThirdRail.Core.Issue
  alias ThirdRail.Core.Comment

  def index(conn, _params) do
    issues = Core.list_issues()
    render(conn, "index.html", issues: issues)
  end

  def new(conn, _params) do
    changeset = Core.change_issue(%Issue{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"issue" => issue_params}) do
    case Core.create_issue(issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue created successfully.")
        |> redirect(to: Routes.issue_path(conn, :show, issue))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    issue = Core.get_issue!(id)
    comment_changeset = Core.change_comment(%Comment{})
    render(conn, "show.html", issue: issue, comment_changeset: comment_changeset)
  end

  def edit(conn, %{"id" => id}) do
    issue = Core.get_issue!(id)
    changeset = Core.change_issue(issue)
    render(conn, "edit.html", issue: issue, changeset: changeset)
  end

  def update(conn, %{"id" => id, "issue" => issue_params}) do
    issue = Core.get_issue!(id)

    case Core.update_issue(issue, issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue updated successfully.")
        |> redirect(to: Routes.issue_path(conn, :show, issue))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", issue: issue, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    issue = Core.get_issue!(id)
    {:ok, _issue} = Core.delete_issue(issue)

    conn
    |> put_flash(:info, "Issue deleted successfully.")
    |> redirect(to: Routes.issue_path(conn, :index))
  end
end
