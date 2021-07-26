defmodule IPay88.SignatureTest do
  use ExUnit.Case
  alias IPay88.Signature

  doctest Signature

  test "generate_payment_request_signature" do
    assert Signature.generate_payment_request_signature("A00000001", "1.00", "MYR") ==
             "110f0be755ccfa9373aa38104bafbc5c6e5462344e44bcfbb70439c82b4b07fa"
  end
end
