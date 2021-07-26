defmodule IPay88.Signature do
  @moduledoc """
  Generate signatures for iPay88
  """

  alias IPay88.Config

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

  def strip_non_number(amount) do
    String.replace("#{amount}", ~r/\D/, "")
  end

  defp encode_string(string) do
    :crypto.hash(:sha256, string) |> Base.encode16() |> String.downcase()
  end
end
