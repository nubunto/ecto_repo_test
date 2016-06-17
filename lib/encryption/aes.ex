defmodule Cards.Encryption.AES do
  def encrypt(plaintext) do
    iv = :crypto.strong_rand_bytes(16)
    state = :crypto.stream_init(:aes_ctr, key, iv)

    {_state, ciphertext} = :crypto.stream_encrypt(state, to_string(plaintext))
    iv <> ciphertext
  end

  def decrypt(ciphertext) do
    <<iv::binary-16, ciphertext::binary>> = ciphertext
    state = :crypto.stream_init(:aes_ctr, key, iv)

    {_state, plaintext} = :crypto.stream_decrypt(state, ciphertext)
    plaintext
  end

  defp key do
    Application.get_env(:cards, Cards.Encryption.AES)[:key]
  end
end
