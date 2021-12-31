defmodule Servy.Handler do
  @moduledoc """
  Handling Request and Responses
  """

  import Servy.Parser, only: [parse: 1]

  require File

  alias Servy.Conv

  @pages_path "pages/about.html"

  def handle(request) do
    request
    |> parse()
    |> route()
    |> format_response()
  end

  def route(%Conv{method: "GET", path: "/transactions"} = conv) do
    body = "[{id: 1, reason: 'Lunch'}, {id: 2, reason: 'transport'}]"

    %{conv | status: 200, body: body}
  end

  def route(%Conv{method: "POST", path: "/transactions"} = conv) do
    %{
      conv
      | status: 201,
        body: "Transaction with id: #{conv.params["id"]} type: #{conv.params["type"]} created."
    }
  end

  def route(%Conv{method: "GET", path: "/transactions/" <> id} = conv) do
    %{conv | status: 200, body: "{id: #{id}, reason: 'Lunch'}"}
  end

  def route(%Conv{method: "GET", path: "/wildthings"} = conv) do
    %{conv | status: 200, body: "Bears, Lions, and Tigers"}
  end

  def route(%Conv{method: "GET", path: "/about"} = conv) do
    {:ok, path} = File.cwd()
    pages_path = Path.join(path, @pages_path)

    case File.read(pages_path) do
      {:ok, content} ->
        %{conv | status: 200, body: content}

      {:error, :enoent} ->
        %{conv | status: 404, body: "File not found!"}

      {:error, reason} ->
        %{conv | status: 500, body: "Reading file error: #{reason}"}
    end
  end

  def route(%Conv{path: path} = conv) do
    %{conv | status: 404, body: "No #{path} found!"}
  end

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.body)}


    #{conv.body}
    """
  end

  def loopy([head | tail]) do
    IO.puts("Head #{head} Tail: #{inspect(tail)}")

    loopy(tail)
  end

  def loopy([]) do
    IO.puts("End of loop")
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

_request = """
GET /about HTTP/1.1
HOST: ingodo.com
USER-Agent: Mozilla/5.0
Accept: text/html,application/xhtml+xml

"""

_request = """
GET /posts HTTP/1.1
HOST: ingodo.com
USER-Agent: Mozilla/5.0
Accept: text/html,application/xhtml+xml

"""

request = """
POST /transactions HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

id=1&type=income
"""

response = Servy.Handler.handle(request)

IO.puts(response)
