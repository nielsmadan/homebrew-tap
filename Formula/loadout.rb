class Loadout < Formula
  include Language::Python::Virtualenv

  desc "Share coding-agent configuration across projects and agents"
  homepage "https://loadoutai.dev"
  url "https://github.com/nielsmadan/loadout/archive/refs/tags/v0.12.0.tar.gz"
  sha256 "f5456d239b8da4c5413ff754b796fda394d1fbd7145b65dc4790c594f0c64166"
  license "MIT"
  head "https://github.com/nielsmadan/loadout.git", branch: "main"

  depends_on "python@3.13"
  uses_from_macos "git"

  resource "shtab" do
    url "https://files.pythonhosted.org/packages/ff/dd/e58588cf2d02266d504f4399979740b8b2b61fbd7719a89578afaa6558a3/shtab-1.13.0.tar.gz"
    sha256 "0a5be9d7ab2b4549e9a38252abcd5ecf5ec6813ecd80c6b06fa851bff55a5085"
  end

  resource "tomlkit" do
    url "https://files.pythonhosted.org/packages/08/72/fc01563df95c189a9f65850096bdc205bc2fe37da6c740cd64afaf18d07e/tomlkit-0.15.2.tar.gz"
    sha256 "83e32755ba1d20d9340bd069ee97e9f6232ba2346b63ffcba425de01f7e327a6"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "loadout", shell_output("#{bin}/loadout --help")
    ENV["XDG_CONFIG_HOME"] = (testpath/"config").to_s
    # Homebrew points HOME at testpath, and loadout refuses to create a migration
    # repository at HOME itself, so the project needs its own directory.
    project = testpath/"project"
    project.mkpath
    system bin/"loadout", "init", "project", "--root", project, "--harness", "claude",
           "--harness", "codex", "--yes"
    system bin/"loadout", "kit", "add", "backend", "--vendored", "--root", project
    system bin/"loadout", "sync", "--root", project
    system bin/"loadout", "check", "--root", project
    instructions = (project/"loadout/kits/backend/instructions.md").read.strip
    assert_match instructions, (project/"AGENTS.md").read
    assert_match "@AGENTS.md", (project/"CLAUDE.md").read
  end
end
