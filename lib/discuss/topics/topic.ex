defmodule Discuss.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  alias Discuss.User

  schema "topics" do
    field(:title, :string)
    belongs_to(:user, User)
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
