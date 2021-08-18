defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Discussions

  plug(DiscussWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete])
  plug(:check_topic_owner when action in [:update, :delete])

  def index(conn, _params) do
    topics = Discussions.get_all_topics()
    render(conn, "index.html", topics: topics)
  end

  def show(conn, %{"id" => id}) do
    topic = Discussions.get_topic!(id)
    render(conn, "show.html", topic: topic)
  end

  def new(conn, _params) do
    changeset = Discussions.new_topic_changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    case Discussions.create_topic(topic, conn.assigns.user) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    {changeset, topic} = Discussions.edit_topic(id)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => id, "topic" => topic}) do
    case Discussions.update_topic(id, topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset, old_topic} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => id}) do
    Discussions.delete_topic!(id)

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Discussions.is_topic_owner?(topic_id, conn.assigns.user.id) do
      conn
    else
      conn
      |> put_flash(:error, "Not your topic")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end
end
