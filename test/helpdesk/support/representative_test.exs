defmodule Helpdesk.Support.RepresentativeTest do
  use Helpdesk.DataCase, async: true

  alias Helpdesk.Support.Ticket
  alias Helpdesk.Support.Representative

  require Ash.Query

  test "create representative" do
    representative =
      Representative
      |> Ash.Changeset.for_create(:create, %{name: "Joe Armstrong"})
      |> Ash.create!()

    assert {:ok, _} = Ecto.UUID.cast(representative.id)
    assert representative.name == "Joe Armstrong"
  end

  test "assign representative to a ticket" do
    representative =
      Representative
      |> Ash.Changeset.for_create(:create, %{name: "Joe Armstrong"})
      |> Ash.create!()

    ticket =
      Ticket
      |> Ash.Changeset.for_create(:open, %{subject: "I can't find my hand!"})
      |> Ash.create!()

    ticket
    |> Ash.Changeset.for_update(:assign, %{representative_id: representative.id})
    |> Ash.update!()
    |> Ash.load!([:representative])

    assert {:ok, _} = Ecto.UUID.cast(ticket.id)
    # IO.inspect(ticket.representative)
    assert ticket.representative.name == "Joe Armstrong"
  end
end
