defmodule Helpdesk.Support.TicketTest do
  use ExUnit.Case

  alias Helpdesk.Support.Ticket

  test "create ticket with subject" do
    ticket =
      Ticket
      |> Ash.Changeset.for_create(
        :open,
        %{subject: "Hello darkness my old friend"}
      )
      |> Ash.create!()

    assert {:ok, _} = Ecto.UUID.cast(ticket.id)
    assert ticket.subject == "Hello darkness my old friend"
  end
end
