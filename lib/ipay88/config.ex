defmodule IPay88.Config do
  @moduledoc """
  Utility that handles interaction with the application's configuration
  """

  @doc """
  In config.exs your implicit or expicit configuration is:
      config :ipay88, json_library: Poison # defaults to Jason but can be configured to Poison
  """
  @spec json_library() :: module
  def json_library do
    resolve(:json_library, Jason)
  end

  @doc """
  In config.exs, use a string, a function or a tuple:
      config :ipay88, merchant_key: System.get_env("IPAY88_MERCHANT_KEY")

  or:
      config :ipay88, merchant_key: {:system, "IPAY88_MERCHANT_KEY"}

  or:
      config :ipay88, merchant_key: {MyApp.Config, :ipay88_merchant_key, []}
  """
  def merchant_key do
    resolve(:merchant_key)
  end

  @doc """
  In config.exs, use a string, a function or a tuple:
      config :ipay88, merchant_code: System.get_env("IPAY88_MERCHANT_CODE")

  or:
      config :ipay88, merchant_code: {:system, "IPAY88_MERCHANT_CODE"}

  or:
      config :ipay88, merchant_code: {MyApp.Config, :ipay88_merchant_code, []}
  """
  def merchant_code do
    resolve(:merchant_code)
  end

  @doc """
  In config.exs, use a string, a function or a tuple:
      config :ipay88, response_url: System.get_env("IPAY88_RESPONSE_URL")

  or:
      config :ipay88, response_url: {:system, "IPAY88_RESPONSE_URL"}

  or:
      config :ipay88, response_url: {MyApp.Config, :ipay88_response_url, []}
  """
  def response_url do
    resolve(:response_url)
  end

  @doc """
  In config.exs, use a string, a function or a tuple:
      config :ipay88, backend_url: System.get_env("IPAY88_BACKEND_URL")

  or:
      config :ipay88, backend_url: {:system, "IPAY88_BACKEND_URL"}

  or:
      config :ipay88, backend_url: {MyApp.Config, :ipay88_backend_url, []}
  """
  def backend_url do
    resolve(:backend_url)
  end

  @doc """
  Resolves the given key from the application's configuration returning the
  wrapped expanded value. If the value was a function it get's evaluated, if
  the value is a touple of three elements it gets applied.
  """

  @spec resolve(atom, any) :: any
  def resolve(key, default \\ nil)

  def resolve(key, default) when is_atom(key) do
    Application.get_env(:ipay88, key, default)
    |> expand_value()
  end

  def resolve(key, _) do
    raise(
      ArgumentError,
      message: "#{__MODULE__} expected key '#{key}' to be an atom"
    )
  end

  defp expand_value({:system, env})
       when is_binary(env) do
    System.get_env(env)
  end

  defp expand_value({module, function, args})
       when is_atom(function) and is_list(args) do
    apply(module, function, args)
  end

  defp expand_value(value) when is_function(value) do
    value.()
  end

  defp expand_value(value), do: value
end
