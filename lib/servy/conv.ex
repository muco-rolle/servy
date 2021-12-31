defmodule Servy.Conv do
  @moduledoc """
  Conv definition
  """

  defstruct method: "", path: "", body: "", status: nil, params: %{}

  def full_status(conv) do
    "#{conv.status} #{status_reason(conv.status)}"
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
