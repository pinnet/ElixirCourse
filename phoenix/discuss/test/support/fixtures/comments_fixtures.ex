defmodule Discuss.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Discuss.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        content: "some content",
        topic_id: 42,
        user_id: 42
      })
      |> Discuss.Comments.create_comment()

    comment
  end
end
