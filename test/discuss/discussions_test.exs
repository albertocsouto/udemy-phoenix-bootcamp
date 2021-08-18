defmodule Discuss.DiscussionsTest do
  use Discuss.DataCase

  alias Discuss.Auth
  alias Discuss.Discussions

  describe "topics" do
    @create_topic %{
      title: "My Topic"
    }

    @create_auth %{
      credentials: %{ token: "my_token"},
      info: %{ email: "my_email@email.com"},
      provider: "my_provider"
    }

    test "get_all_topics/0 returns all topics" do
      {:ok, user} = Auth.signin(@create_auth)
      {:ok, topic} = Discussions.create_topic(@create_topic, user)
      topics = Discussions.get_all_topics()
      assert [topic] == topics
    end

    test "get_topic/1 return topic" do
      {:ok, user} = Auth.signin(@create_auth)
      {:ok, topic} = Discussions.create_topic(@create_topic, user)
      assert Discussions.get_topic!(topic.id) == topic
    end
  end
end
