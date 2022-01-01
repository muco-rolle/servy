defmodule Servy.PostsController do
  @moduledoc """
  Posts Controller
  """

  alias Servy.Post

  def index(conv) do
    posts = Post.all()

    template = fn post ->
      """
        <ul>
          <li>#{post.id} - #{post.title}</li>
          <li>#{post.body}</li>
        </ul>
      """
    end

    posts_template = Enum.map_join(posts, template)

    %{conv | status: 200, body: posts_template}
  end

  def show do
  end

  def create do
  end

  def update do
  end

  def delete do
  end
end
