defmodule Servy.Handler do
  @moduledoc """
  Handling Request and Responses
  """

  import Servy.Parser, only: [parse: 1]

  alias Servy.Conv
  alias Servy.PostsController

  def handle(request) do
    request
    |> parse()
    |> route()
    |> format_response()
  end

  def route(%Conv{method: "GET", path: "/posts"} = conv) do
    PostsController.index(conv)
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

request = """
GET /posts HTTP/1.1
HOST: ingodo.com
USER-Agent: Mozilla/5.0
Accept: text/html,application/xhtml+xml

id=1&type=income
"""

_request = """
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
