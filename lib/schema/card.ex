defmodule Cards.Schemas.Card do
  use Ecto.Schema

  import Ecto
  import Ecto.Changeset
  import Ecto.Query, only: [from: 1, from: 2]

  alias Cards.Schemas.Card
  #alias Cards.Repo

  schema "cards" do
    field :label, :string
    field :comentario, :string
    field :trilha_2, Cards.Encryption.Field
    field :trilha_1, Cards.Encryption.Field
    field :cod_seguranca, :string
    field :senha, :string
    field :trilha1_5dig, :string
    field :pan, :string
    field :pan_mask, :string

    timestamps
  end

  defp calculate(changeset, :trilha1_5dig) do
    case get_field(changeset, :trilha_1) do
      nil -> changeset
      trilha_1 ->
        ret = with [_first, name | _rest] <- trilha_1 |> String.split("^"),
             grph = String.graphemes(name),
             digits =
              [Enum.at(grph, 2), Enum.at(grph, 4), Enum.at(grph, 6), Enum.at(grph, 10), Enum.at(grph, 12)]
              |> Enum.join() do
          {:ok, put_change(changeset, :trilha1_5dig, digits)}
        end
        case ret do
          {:ok, ch} ->
            ch
          _ ->
            changeset
        end
    end
  end

  defp calculate(changeset, :pan) do
    # o PAN é calculado usando a primeira parte do separador.
    case get_field(changeset, :trilha_2) do
      nil ->
        changeset
      trilha_2 ->
        [pan | _] = trilha_2
          |> String.replace("D", "=")
          |> String.split("=")
        put_change(changeset, :pan, pan)
    end
  end

  defp put_mask(changeset) do
    case get_field(changeset, :pan) do
      nil -> changeset
      pan ->
        len = String.length(pan)
        middle_length = if len <= 12, do: 4, else: len - 10
        rest =
          String.slice(pan, 6, 6) <> ((for _ <- 1..middle_length, do: "*") |> Enum.join) <> String.slice(pan, -4, 4)
        put_change(changeset, :pan_mask, rest)
    end
  end

  @required_fields ~w(label comentario trilha_2 trilha_1)
  @optional_fields ~w(cod_seguranca senha trilha1_5dig pan)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:label)
    |> validate_format(:trilha_1, ~r/[0-9]+\^[A-Z\s]+\^[A-z0-9]/)
    |> validate_length(:trilha_2, min: 11, max: 255)
    |> validate_length(:label, min: 3, max: 255)
    |> validate_length(:comentario, max: 255)
    |> validate_length(:cod_seguranca, max: 255)
    |> validate_length(:senha, max: 255)
    |> update_change(:label, &String.strip/1)
    |> update_change(:comentario, &String.strip/1)
    |> update_change(:trilha_2, &String.strip/1)
    |> update_change(:trilha_1, &String.strip/1)
    |> update_change(:cod_seguranca, &String.strip/1)
    |> update_change(:senha, &String.strip/1)
    |> calculate(:trilha1_5dig)
    |> calculate(:pan)
    |> put_mask
  end
end
