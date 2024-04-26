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

  # TODO: fix test
  #   test "create ticket without subject" do
  #     Ticket
  #     |> Ash.Changeset.for_create(
  #       :open,
  #       %{}
  #     )
  #     |> Ash.Test.refute_has_error()
  #   end

  test "updates and validations" do
    ticket =
      Helpdesk.Support.Ticket
      |> Ash.Changeset.for_create(:open, %{subject: "My mouse won't click!"})
      |> Ash.create!()
      |> Ash.Changeset.for_update(:close)
      |> Ash.update!()

    assert {:ok, _} = Ecto.UUID.cast(ticket.id)
    assert ticket.subject == "My mouse won't click!"
  end
end
