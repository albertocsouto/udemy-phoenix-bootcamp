defmodule Discuss.Discussions.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  alias Discuss.Auth.User
  alias Discuss.Discussions.Comment

  schema "topics" do
    field(:title, :string)
    belongs_to(:user, User)
    has_many(:comments, Comment)
  end

  @doc false
  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [
      :title
    ])
    |> validate_required([
      :title
    ])
  end
end
