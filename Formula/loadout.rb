class Loadout < Formula
  include Language::Python::Virtualenv

  desc "Share coding-agent configuration across projects and agents"
  homepage "https://loadoutai.dev"
  url "https://github.com/nielsmadan/loadout/archive/refs/tags/v0.9.3.tar.gz"
  sha256 "8a2104e9b4eba646911c6588e76e867d47251682ad905f401de9f60a6ae8cc3e"
  license "MIT"
  head "https://github.com/nielsmadan/loadout.git", branch: "main"

  depends_on "python@3.13"
  uses_from_macos "git"

  resource "tomlkit" do
    url "https://files.pythonhosted.org/packages/94/96/e07752635b98536177fa1f37671c8f3cdde2e724c6bcf6034b2cfb571565/tomlkit-0.15.1.tar.gz"
    sha256 "e25bbf38843005246210a12982776f27f99cb9be67160e14434d0c0d21ee1e97"
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
    system bin/"loadout", "init", "--project", "--root", project, "--harness", "claude",
           "--harness", "codex", "--starter", "backend", "--yes"
    system bin/"loadout", "sync", "--root", project
    system bin/"loadout", "check", "--root", project
    instructions = (project/"loadout/templates/backend/instructions.md").read.strip
    assert_match instructions, (project/"CLAUDE.md").read
    assert_match instructions, (project/"AGENTS.md").read
  end
end
