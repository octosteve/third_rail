defmodule ThirdRail.Core do
  @moduledoc """
  The Core context.
  """

  import Ecto.Query, warn: false
  alias ThirdRail.Repo

  alias ThirdRail.Core.Issue
  alias ThirdRail.Core.Comment

  @doc """
  Returns the list of issues.

  ## Examples

      iex> list_issues()
      [%Issue{}, ...]

  """
  def list_issues do
    Repo.all(Issue)
  end

  @doc """
  Returns the list comments for issue.

  ## Examples

      iex> list_comments_for_issue(issue_id)
      [%Issue{}, ...]

  """
  def list_comments_for_issue(issue_id) do
    query =
      from c in Comment,
        where: c.issue_id == ^issue_id

    Repo.all(query)
  end

  @doc """
  Gets a single issue.

  Raises `Ecto.NoResultsError` if the Issue does not exist.

  ## Examples

      iex> get_issue!(123)
      %Issue{}

      iex> get_issue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_issue!(id), do: Repo.get!(Issue, id)

  @doc """
  Creates a issue.

  ## Examples

      iex> create_issue(%{field: value})
      {:ok, %Issue{}}

      iex> create_issue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_issue(attrs \\ %{}) do
    %Issue{}
    |> Issue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a comment for an issue.

  ## Examples

      iex> create_comment_for_issue(issue_id, comment_params)
      {:ok, %Comment{}}

      iex> create_comment_for_issue(issue_id, comment_params)
      {:error, issue, %Ecto.Changeset{}}

  """
  def create_comment_for_issue(issue_id, comment_params) do
    issue = Repo.get!(Issue, issue_id)

    case issue
         |> Ecto.build_assoc(:comments)
         |> change_comment(comment_params)
         |> Repo.insert() do
      {:ok, _comment} = result -> result
      {:error, changeset} -> {:error, issue, changeset}
    end
  end

  @doc """
  Updates a issue.

  ## Examples

      iex> update_issue(issue, %{field: new_value})
      {:ok, %Issue{}}

      iex> update_issue(issue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_issue(%Issue{} = issue, attrs) do
    issue
    |> Issue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a issue.

  ## Examples

      iex> delete_issue(issue)
      {:ok, %Issue{}}

      iex> delete_issue(issue)
      {:error, %Ecto.Changeset{}}

  """
  def delete_issue(%Issue{} = issue) do
    Repo.delete(issue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking issue changes.

  ## Examples

      iex> change_issue(issue)
      %Ecto.Changeset{data: %Issue{}}

  """
  def change_issue(%Issue{} = issue, attrs \\ %{}) do
    Issue.changeset(issue, attrs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking issue changes.

  ## Examples

      iex> change_comment(comment)
      %Ecto.Changeset{data: %Comment{}}

  """
  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end
end
