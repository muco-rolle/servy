defmodule Servy.Parser do
  @moduledoc """
  Parse request
  """

  alias Servy.Conv

  def parse(request) do
    [top, params] = String.split(request, "\n\n")

    [request_line | _headers] = String.split(top, "\n")

    [method, path, _] = request_line |> String.split(" ")

    %Conv{method: method, path: path, params: URI.decode_query(params)}
  end
end
