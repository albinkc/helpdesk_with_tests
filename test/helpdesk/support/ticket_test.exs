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

  test "data layer" do
    # Use this to pick up changes you've made to your code, or restart your session

    require Ash.Query

    for i <- 0..5 do
      ticket =
        Helpdesk.Support.Ticket
        |> Ash.Changeset.for_create(:open, %{subject: "Issue #{i}"})
        |> Ash.create!()

      if rem(i, 2) == 0 do
        ticket
        |> Ash.Changeset.for_update(:close)
        |> Ash.update!()
      end
    end

    # Show the tickets where the subject contains "2"
    Helpdesk.Support.Ticket
    |> Ash.Query.filter(contains(subject, "2"))
    |> Ash.read!()

    # Show the tickets that are closed and their subject does not contain "4"
    output =
      Helpdesk.Support.Ticket
      |> Ash.Query.filter(status == :closed and not contains(subject, "4"))
      |> Ash.read!()

    # |> Ash.first!(:id)

    assert {:ok, _} = Ecto.UUID.cast(hd(output).id)
  end
end
