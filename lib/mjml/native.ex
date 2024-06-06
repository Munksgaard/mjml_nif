defmodule Mjml.Native do
  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]

  targets = ~w(
    aarch64-apple-darwin
    aarch64-unknown-linux-gnu
    aarch64-unknown-linux-musl
    riscv64gc-unknown-linux-gnu
    x86_64-apple-darwin
    x86_64-pc-windows-gnu
    x86_64-pc-windows-msvc
    x86_64-unknown-linux-gnu
    x86_64-unknown-linux-musl
  )

  nif_versions = ~w(
    2.15
    2.16
  )

  use Rustler,
    otp_app: :mjml,
    crate: "mjml_nif"

  def to_html(_mjml, _render_options), do: error()
  defp error(), do: :erlang.nif_error(:nif_not_loaded)
end
