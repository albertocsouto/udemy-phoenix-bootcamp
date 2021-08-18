defmodule Discuss.Discussions do
  alias Discuss.Repo
  alias Discuss.Discussions.Topic

  def get_all_topics() do
    Repo.all(Topic)
  end

  def get_topic!(id) do
    Repo.get!(Topic, id)
  end

  def new_topic_changeset() do
    Topic.changeset(%Topic{}, %{})
  end

  def create_topic(topic, user) do
    changeset =
      user
      |> Ecto.build_assoc(:topics)
      |> Topic.changeset(topic)

    Repo.insert(changeset)
  end

  def edit_topic(id) do
    topic = Repo.get(Topic, id)
    {Topic.changeset(topic), topic}
  end

  def update_topic(topic_id, updated_topic) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, updated_topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        {:ok, updated_topic}

      {:error, changeset} ->
        {:error, changeset, old_topic}
    end
  end

  def delete_topic!(id) do
    Repo.get!(Topic, id)
    |> Repo.delete!()
  end

  def is_topic_owner?(topic_id, user_id) do
    Repo.get(Topic, topic_id).user_id == user_id
  end
end
