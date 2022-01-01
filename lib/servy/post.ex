defmodule Servy.Post do
  @moduledoc """
    Post Model
  """
  defstruct id: nil, title: nil, body: nil

  def list_posts() do
    [
      %Servy.Post{id: 1, title: "First post title", body: "First post body"},
      %Servy.Post{id: 2, title: "Second post title", body: "Second post body"},
      %Servy.Post{id: 3, title: "Third post title", body: "FThird ost body"},
      %Servy.Post{id: 4, title: "Fourth post title", body: "FFourthpost body"},
      %Servy.Post{id: 5, title: "Fifth post title", body: "Firifth st body"}
    ]
  end

  def get_post(id) when is_integer(id) do
    list_posts() |> Enum.find(fn post -> post.id == id end)
  end

  def get_post(id) when is_binary(id) do
    id |> String.to_integer() |> get_post()
  end
end
