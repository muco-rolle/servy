defmodule Servy.Handler do
  @moduledoc """
  Handling Request and Responses
  """

  require Logger

  def handle(request) do
    request
    |> parse()
    |> log()
    |> route()
    |> format_response()
  end

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{
      method: method,
      path: path,
      body: "",
      status: nil
    }
  end

  def log(conv) do
    Logger.info(conv)

    conv
  end

  def route(%{method: "GET", path: "/transactions"} = conv) do
    body = "[{id: 1, reason: 'Lunch'}, {id: 2, reason: 'transport'}]"

    %{conv | status: 200, body: body}
  end

  def route(%{method: "GET", path: "/transactions/" <> id} = conv) do
    %{conv | status: 200, body: "{id: #{id}, reason: 'Lunch'}"}
  end

  def route(%{method: "GET", path: "/wildthings"} = conv) do
    %{conv | status: 200, body: "Bears, Lions, and Tigers"}
  end

  def route(%{path: path} = conv) do
    %{conv | status: 404, body: "No #{path} found!"}
  end

  def format_response(%{body: body, status: status}) do
    """
    HTTP/1.1 #{status} #{status_reason(status)}
    Content-Type: text/html
    Content-Length: #{String.length(body)}

    #{body}
    """
  end

  defp status_reason(code) do
    statuses = %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not found",
      500 => "Internal Server Error"
    }

    statuses[code]
  end
end

_request = """
GET /transactions/2 HTTP/1.1
HOST: ingodo.com
USER-Agent: Mozilla/5.0
Accept: text/html,application/xhtml+xml

"""

_request = """
GET /wildthings HTTP/1.1
HOST: ingodo.com
USER-Agent: Mozilla/5.0
Accept: text/html,application/xhtml+xml

"""

request = """
GET /posts HTTP/1.1
HOST: ingodo.com
USER-Agent: Mozilla/5.0
Accept: text/html,application/xhtml+xml

"""

response = Servy.Handler.handle(request)

IO.puts(response)
