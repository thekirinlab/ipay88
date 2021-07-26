defmodule IPay88.API do
  @moduledoc """
  Utilities for interacting with the IPay88 API.
  API Doc: https://hit-pay.com/docs.html
  """

  alias IPay88.{Config, Request, Signature}

  @api_path "https://payment.ipay88.com.my/epayment"
  @credit_card_payment_id 2

  @type method :: :get | :post | :put | :delete | :patch
  @type headers :: %{String.t() => String.t()} | %{}

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

  @doc """
  Create a payment request
  """

  @spec create_payment(create_payment_params, headers, map) ::
          {:ok, map} | {:error, any()}
  def create_payment(body, headers \\ %{}, opts \\ []) do
    req_url = build_path("/entry.asp")

    req_body =
      %{
        "MerchantCode" => Config.merchant_code(),
        "PaymentId" => body[:payment_id] || @credit_card_payment_id,
        "Currency" => body[:currency] || "MYR",
        "SignatureType" => "SHA256",
        "Response URL" => body[:response_url] || Config.response_url(),
        "Backend URL" => body[:backend_url] || Config.backend_url(),
        "Remark" => body[:remark] || "",
        # the following fields are mandatory that client need to provide
        "RefNo" => body[:ref_no],
        "Amount" => body[:amount],
        "ProdDesc" => body[:prod_desc],
        "UserName" => body[:user_name],
        "UserEmail" => body[:user_email],
        "UserContact" => body[:user_contact]
      }
      |> Map.merge(body)

    signature =
      Signature.generate_payment_request_signature(
        req_body["RefNo"],
        req_body["Amount"],
        req_body["Currency"]
      )

    req_body =
      Map.merge(req_body, %{
        "Signature" => signature
      })

    Request.request(:post, req_url, req_body, headers, opts)
    |> case do
      {:ok, ""} ->
        {:ok, %{}}

      {:ok, body} ->
        decoded_body = Config.json_library().decode!(body)
        {:ok, decoded_body}

      error ->
        error
    end
  end

  defp build_path(path) do
    if String.starts_with?(path, "/") do
      "#{@api_path()}#{path}"
    else
      "#{@api_path()}/#{path}"
    end
  end
end
