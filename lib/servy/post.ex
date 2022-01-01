defmodule Servy.Post do
  @moduledoc """
    Post Model
  """
  defstruct id: nil, title: nil, body: nil

  def all() do
    [
      %Servy.Post{id: 1, title: "First post title", body: "First post body"},
      %Servy.Post{id: 2, title: "Second post title", body: "Second post body"},
      %Servy.Post{id: 3, title: "Third post title", body: "FThird ost body"},
      %Servy.Post{id: 4, title: "Fourth post title", body: "FFourthpost body"},
      %Servy.Post{id: 5, title: "Fifth post title", body: "Firifth st body"}
    ]
  end
end
