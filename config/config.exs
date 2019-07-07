# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :password_reset,
  ecto_repos: [PasswordReset.Repo]

# Configures the endpoint
config :password_reset, PasswordReset.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4tbpFn3OF3YCbF3DjR+opYbMksduhzvS0D5f5neC1GFiGsgHPnkoZ9Q3p22bn4Zj",
  render_errors: [view: PasswordReset.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PasswordReset.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure mailing
config :password_reset, PasswordReset.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "",
  port: 587,
  username: "",
  password: "",
  tls: :always, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
