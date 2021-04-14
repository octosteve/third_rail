defmodule ThirdRail.Core.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :content, :binary
    belongs_to :issue, ThirdRail.Core.Issue

    timestamps()
  end

  @doc false
  def changeset(comments, attrs) do
    comments
    |> cast(attrs, [:content])
  end
end
