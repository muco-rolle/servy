defmodule Servy.Parser do
  @moduledoc """
  Parse request
  """

  require Logger
  alias Servy.Conv

  def parse(request) do
    [top, params] = String.split(request, "\n\n")

    [request_line | headers] = String.split(top, "\n")

    [method, path, _] = request_line |> String.split(" ")

    %Conv{
      method: method,
      path: path,
      params: URI.decode_query(params),
      headers: parse_headers(headers, %{})
    }
  end

  def parse_headers([head | tail], headers) do
    [key, value] = String.split(head, ": ")

    headers = Map.put(headers, key, value)

    parse_headers(tail, headers)
  end

  def parse_headers([], headers), do: headers
end
