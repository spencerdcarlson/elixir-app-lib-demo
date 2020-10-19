defmodule DemoAppWeb.Controller do
  use DemoAppWeb, :controller
  use PhoenixSwagger

  action_fallback DemoAppWeb.FallbackController

  swagger_path :health do
    get "/health"
    summary "Get the status of demo_app and demo_lib"
    response 200, """
    {"demo_app": true, "demo_lib": true}
    """
  end

  swagger_path :lib do
    get "/lib/{action}"
    summary "Perform an action on the :demo_lib library"
    parameters do
      action :path, :string, "action", required: true, enum: ~w(cast call error crash restart none)
    end
    response 200, ""
  end

  def health(conn, _params) do
    apps = Application.started_applications()

    json(
      conn,
      %{
        demo_app: Enum.any?(apps, &has_name(&1, :demo_app)),
        demo_lib: Enum.any?(apps, &has_name(&1, :demo_lib))
      }
    )
  end

  defp has_name({app, _, _}, name), do: app == name

  # Lib endpoints
  def lib(conn, %{"action" => "error"}) do
    DemoLib.raise_after()
    json(conn, "ok")
  end

  def lib(conn, %{"action" => "crash"}) do
    DemoLib.kill()
    json(conn, "ok")
  end

  def lib(conn, %{"action" => "cast"}) do
    DemoLib.put_secret("my-cool-secret")
    json(conn, "ok")
  end

  def lib(conn, %{"action" => "call"}) do
    json(conn, DemoLib.get_secret())
  end

  def lib(conn, %{"action" => "none"}) do
    json(conn, "ok")
  end

  def lib(conn, %{"action" => "restart"}) do
    if Enum.any?(Application.started_applications(), &has_name(&1, :demo_lib)) do
      json(conn, "already started")
    else
      case Application.ensure_all_started(:demo_lib) do
        {:ok, [:demo_lib]} -> json(conn, "started")
        _ ->
          conn
          |> put_status(400)
          |> json("not started")
      end
    end
  end

  def lib(conn, _) do
    conn
    |> put_status(404)
    |> json("Bad value. Accepted action values: [cast, call, error, crash, restart, none]")
  end

end
