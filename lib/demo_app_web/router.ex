defmodule DemoAppWeb.Router do
  use DemoAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DemoAppWeb do
    pipe_through :api
    get "/health", Controller, :health
    get "/lib/:action", Controller, :lib
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :demo_app, swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Demo App"
      },
      basePath: "/api"
    }
  end
end
