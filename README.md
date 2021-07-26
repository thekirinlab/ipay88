# IPay88

An Elixir client for iPay88 Payment Gateway

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ipay88` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ipay88, "~> 0.1.2"}
  ]
end
```
## Configuration

To use iPay88 API, we need to setup a an account and retrieve merchant key and code.

```elixir
config :ipay88,
  merchant_key: System.get_env("IPAY88_MERCHANT_KEY"),
  merchant_code: {MyApp.Config, :ipay88_merchant_code, []}
```

or

```elixir
config :ipay88,
  merchant_key: {:system, "IPAY88_MERCHANT_KEY"},
  merchant_code: {:system, "IPAY88_MERCHANT_CODE"}
```

You can also use the JSON libary of your choice, Jason is used by default

```elixir
config :ipay88, json_library: Poison
```

## Using the API

### To create a payment request

```elixir
%{
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
```

Additional documentation can be found at [https://hexdocs.pm/ipay88](https://hexdocs.pm/ipay88).

