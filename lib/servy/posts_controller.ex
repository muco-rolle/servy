defmodule Servy.PostsController do
  @moduledoc """
  Posts Controller
  """

  alias Servy.Post

  def index(conv) do
    posts = Post.list_posts()

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

  def show(conv, id) do
    post = Post.get_post(id)

    post_template = """
      <ul>
        <li>#{post.id} - #{post.title}</li>
        <li>#{post.body} </li>
      </ul>
    """

    %{conv | status: 200, body: post_template}
  end

  def create do
  end

  def update do
  end

  def delete do
  end
end
