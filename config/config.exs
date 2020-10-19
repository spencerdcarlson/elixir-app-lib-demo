# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

#config :demo_app,
#  ecto_repos: [DemoApp.Repo]

# Configures the endpoint
config :demo_app, DemoAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FI+QC7/Lg5tKEhLKD8sP+b6+UfKD19y6xohwm0TM9iPDS7BTz4v2V9h4ICSVhB3I",
  render_errors: [view: DemoAppWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: DemoApp.PubSub, adapter: Phoenix.PubSub.PG2]

config :demo_app, :phoenix_swagger,
       swagger_files: %{
         "priv/static/swagger.json" => [
           router: DemoAppWeb.Router,     # phoenix routes will be converted to swagger paths
           endpoint: DemoAppWeb.Endpoint  # (optional) endpoint config used to set host, port and https schemes.
         ]
       }

config :phoenix_swagger, json_library: Jason

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
