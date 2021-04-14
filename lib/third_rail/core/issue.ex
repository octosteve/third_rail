defmodule ThirdRail.Core.Issue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "issues" do
    field :content, :binary
    field :title, :string
    has_many :comments, ThirdRail.Core.Comment

    timestamps()
  end

  @doc false
  def changeset(issue, attrs) do
    issue
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
