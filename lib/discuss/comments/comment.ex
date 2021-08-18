defmodule Discuss.Discussions.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Discuss.Auth.User
  alias Discuss.Discussions.Topic

  @derive {Jason.Encoder, only: [:content, :user]}

  schema "comments" do
    field(:content, :string)
    belongs_to(:user, User)
    belongs_to(:topic, Topic)

    timestamps()
  end

  @doc false
  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [
      :content
    ])
    |> validate_required([
      :content
    ])
  end
end
