import Config

config :helpdesk,
  ash_domains: [Helpdesk.Support]

config :helpdesk,
  ecto_repos: [Helpdesk.Repo]

import_config("#{config_env()}.exs")
