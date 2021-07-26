defmodule IPay88 do
  @moduledoc """
  Documentation for `Ipay88`.
  """

  alias IPay88.API

  @doc """
  Create Payment

  ## Examples

      iex> %{
        ref_no: "Order-1023",
        amount: "1.00",
        prod_desc: "A box of chocolate",
        user_name: "John Doe",
        user_email: "john.doe@example.com",
        user_contact: "+123456789",
        payment_id: 2,
        currency: "MYR",
        response_url: "https://example.com/ipay88_response",
        backend_url: "https://example.com/ipay88_webhook",
        remark: "This is a test request"
      } |> IPay88.create_payment()
  """
  def create_payment(params) do
    API.create_payment(params)
  end
end
