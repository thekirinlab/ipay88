defmodule IPay88.Signature do
  @moduledoc """
  Generate signatures for iPay88
  """

  alias IPay88.Config

  @doc """
  Generate signature using SHA-256

  ## Examples

      iex> IPay88.Signature.generate_payment_request_signature("A00000001", "1.00", "MYR")
      "110f0be755ccfa9373aa38104bafbc5c6e5462344e44bcfbb70439c82b4b07fa"
  """
  def generate_payment_request_signature(ref_no, amount, currency \\ "MYR") do
    [
      Config.merchant_key(),
      Config.merchant_code(),
      ref_no,
      strip_non_number(amount),
      String.upcase(currency)
    ]
    |> Enum.join("")
    |> encode_string()
  end

  defp strip_non_number(amount) do
    String.replace("#{amount}", ~r/\D/, "")
  end

  defp encode_string(string) do
    :crypto.hash(:sha256, string) |> Base.encode16() |> String.downcase()
  end
end
