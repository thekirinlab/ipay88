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
        currency: "MYR",
        response_url: "https://example.com/ipay88_response",
        backend_url: "https://example.com/ipay88_webhook",
        remark: "This is a test request"
      } |> IPay88.create_payment()
  """

  @type create_payment_params :: %{
          ref_no: String.t(),
          amount: String.t(),
          prod_desc: String.t(),
          user_name: String.t(),
          user_email: String.t(),
          user_contact: String.t(),
          payment_id: Integer.t() | nil,
          currency: String.t() | nil,
          response_url: String.t() | nil,
          backend_url: String.t() | nil,
          remark: String.t() | nil
        }

  @spec create_payment(create_payment_params) ::
          {:ok, map} | {:error, any()}
  def create_payment(params) do
    API.create_payment(params)
  end
end
