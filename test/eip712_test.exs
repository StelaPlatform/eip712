defmodule Eip712Test do
  use ExUnit.Case
  doctest Eip712

  test "encode expects ok" do
    message = """
    {"types":{"EIP712Domain":[{"name":"name","type":"string"},{"name":"version","type":"string"},{"name":"chainId","type":"uint256"},{"name":"verifyingContract","type":"address"}],"Nft":[{"name":"tokenHash","type":"string"},{"name":"price","type":"uint256"},{"name":"receivers","type":"address[]"},{"name":"percents","type":"uint256[]"}]},"primaryType":"Nft","domain":{"name":"Gallery","version":"4","chainId":"0x7A69","verifyingContract":"0x5FbDB2315678afecb367f032d93F642f64180aa3"},"message":{"tokenHash":"1e59237e-f0f6-48b5-b384-17270eab0abb","price":"0x6F05B59D3B20000","receivers":["0x70997970C51812dc3A010C7d01b50e0d17dc79C8","0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC"],"percents":["0x7D0","0x3E8"]}}
    """

    assert Eip712.encode(message) ==
             {:ok, "0xac03eeb19f3eb9939d33ebc5e59c9f89cd215100a8035c658c8016f6170cfa85"}
  end

  test "encode expects error" do
    message = """
    Invalid
    """

    {:error, _} = Eip712.encode(message)
  end
end
