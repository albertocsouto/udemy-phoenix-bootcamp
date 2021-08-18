defmodule Discuss.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Discuss.Discussions.Topic
  alias Discuss.Discussions.Comment

  @derive {Jason.Encoder, only: [:email]}

  schema "users" do
    field(:email, :string)
    field(:provider, :string)
    field(:token, :string)
    has_many(:topics, Topic)
    has_many(:comment, Comment)

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [
      :email,
      :provider,
      :token
    ])
    |> validate_required([
      :email,
      :provider,
      :token
    ])
  end
end
