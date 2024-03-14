defmodule InstatusAPIConsumerWeb.FallbackController do
  use InstatusAPIConsumerWeb, :controller

  # TODO: add a custom error message
  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(400)
    |> put_view(json: InstatusAPIConsumerWeb.ErrorJSON)
    |> render("400.json")
  end
end
