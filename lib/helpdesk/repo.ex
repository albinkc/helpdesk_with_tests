defmodule Helpdesk.Repo do
  use AshPostgres.Repo, otp_app: :helpdesk

  def installed_extensions do
    ["ash-functions"]
  end
end
