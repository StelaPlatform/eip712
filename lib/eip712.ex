defmodule Eip712 do
  use Rustler,
    otp_app: :eip712,
    crate: "eip712"

  @moduledoc """
  Encode typed data as described in `Eip712`.
  """

  @doc """
  Encode typed data as described in `Eip712`.
  The type of `uint256` must be passed in as hex string prefixed by `0x`, for example, `chainId` must
  be passed as `"chainId":"0x01"` in the message rather than `"chainId":1`

  ## Examples

      iex> message = ~s({"types":{"EIP712Domain":[{"name":"name","type":"string"},{"name":"version","type":"string"},{"name":"chainId","type":"uint256"},{"name":"verifyingContract","type":"address"}],"Nft":[{"name":"tokenHash","type":"string"},{"name":"price","type":"uint256"},{"name":"receivers","type":"address[]"},{"name":"percents","type":"uint256[]"}]},"primaryType":"Nft","domain":{"name":"Gallery","version":"4","chainId":"0x7A69","verifyingContract":"0x5FbDB2315678afecb367f032d93F642f64180aa3"},"message":{"tokenHash":"1e59237e-f0f6-48b5-b384-17270eab0abb","price":"0x6F05B59D3B20000","receivers":["0x70997970C51812dc3A010C7d01b50e0d17dc79C8","0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC"],"percents":["0x7D0","0x3E8"]}})
      iex> Eip712.encode(message)
      {:ok, "0xac03eeb19f3eb9939d33ebc5e59c9f89cd215100a8035c658c8016f6170cfa85"}

      iex> message = ~s({"types":{"EIP712Domain":[{"name":"name","type":"string"},{"name":"version","type":"string"},{"name":"chainId","type":"uint256"},{"name":"verifyingContract","type":"address"}],"Person":[{"name":"name","type":"string"},{"name":"wallet","type":"address"}],"Mail":[{"name":"from","type":"Person"},{"name":"to","type":"Person"},{"name":"contents","type":"string"}]},"primaryType":"Mail","domain":{"name":"Ether Mail","version":"1","chainId":"0x01","verifyingContract":"0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC"},"message":{"from":{"name":"Cow","wallet":"0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826"},"to":{"name":"Bob","wallet":"0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB"},"contents":"Hello, Bob!"}})
      iex> Eip712.encode(message)
      {:ok, "0xbe609aee343fb3c4b28e1df9e632fca64fcfaede20f02e86244efddf30957bd2"}

      iex> message = ~s({"types":{"EIP712Domain":[{"type":"string","name":"name"},{"type":"string","name":"version"},{"type":"uint256","name":"chainId"}],"ReplyTo":[{"type":"string","name":"news_url"}],"Comment":[{"type":"string","name":"content"},{"type":"string","name":"author_address"},{"type":"string","name":"author_chain"},{"type":"ReplyTo","name":"reply_to"}]},"primaryType":"Comment","message":{"reply_to":{"news_url":"https://www.nytimes.com/2023/01/12/us/school-shootings-security.html#commentsContainer"},"content":"It is simply insane that we are turning our schools into prison-like fortresses because we can't overcome the obsessive lobbying of gun fetishists. The adults in this country have left the room.","author_chain":"ETHEREUM","author_address":"0x70997970c51812dc3a010c7d01b50e0d17dc79c8"},"domain":{"version":"1","name":"Stela","chainId":"0x7A69"}})
      iex> Eip712.encode(message)
      {:ok, "0xd955b7f563f2a50d22bec114e00e2295fc4e9ba90bb34868e6b79a0e8991c7f3"}
  """
  @spec encode(String.t()) :: {:ok, String.t()} | {:error, binary()}
  def encode(_message), do: :erlang.nif_error(:nif_not_loaded)
end
