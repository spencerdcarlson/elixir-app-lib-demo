defmodule DemoAppWeb.FallbackController do
  use DemoAppWeb, :controller

  def call(conn, params) do
    json(conn, params)
  end
end
