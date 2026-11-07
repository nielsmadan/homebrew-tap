class Loadout < Formula
  include Language::Python::Virtualenv

  desc "Share coding-agent configuration across projects and agents"
  homepage "https://loadoutai.dev"
  url "https://github.com/nielsmadan/loadout/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "ca9df5cfec6e9d3e5024628a60de8a0b133fb6ef65fe6937fa63fca9b7a03f71"
  license "MIT"
  head "https://github.com/nielsmadan/loadout.git", branch: "main"

  depends_on "python@3.13"
  uses_from_macos "git"

  resource "shtab" do
    url "https://files.pythonhosted.org/packages/ef/71/ddb3c0a7a86db44d2fb3f9cbac162f7ddbcbf563b4a174963ba2b3d4d819/shtab-1.12.1.tar.gz"
    sha256 "0637338723a8fc08ed1c2fd826d8432229924649c26e3247bb48c53d60ca3bf9"
  end

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
    system bin/"loadout", "init", "project", "--root", project, "--harness", "claude",
           "--harness", "codex", "--yes"
    system bin/"loadout", "template", "add", "backend", "--vendored", "--root", project
    system bin/"loadout", "sync", "--root", project
    system bin/"loadout", "check", "--root", project
    instructions = (project/"loadout/templates/backend/instructions.md").read.strip
    assert_match instructions, (project/"AGENTS.md").read
    assert_match "@AGENTS.md", (project/"CLAUDE.md").read
  end
end
