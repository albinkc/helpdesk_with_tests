defmodule Helpdesk.Support.RepresentativeTest do
  use Helpdesk.DataCase, async: true

  alias Helpdesk.Support.Ticket
  alias Helpdesk.Support.Representative

  defp create_representative(name) do
    Representative
    |> Ash.Changeset.for_create(:create, %{name: name})
    |> Ash.create!()
  end

  test "create representative" do
    representative = create_representative("Joe Armstrong")
    assert {:ok, _} = Ecto.UUID.cast(representative.id)
    assert representative.name == "Joe Armstrong"
  end

  test "assign representative to a ticket" do
    representative = create_representative("Joe Armstrong")

    ticket =
      Ticket
      |> Ash.Changeset.for_create(:open, %{subject: "I can't find my hand!"})
      |> Ash.create!()
      |> Ash.Changeset.for_update(:assign, %{representative_id: representative.id})
      |> Ash.update!()
      |> Ash.load!([:representative])

    assert {:ok, _} = Ecto.UUID.cast(ticket.id)
    assert ticket.representative.name == "Joe Armstrong"
  end
end
