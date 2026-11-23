class Callboard < Formula
  include Language::Python::Virtualenv

  desc "Chat, mail and pings between coding agents, rung through bellhop"
  homepage "https://github.com/nielsmadan/callboard"
  url "https://github.com/nielsmadan/callboard/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "088555a1c738f44d8918794f0c95e081261733239c1d67fcea09e5180ec13077"
  license "MIT"
  head "https://github.com/nielsmadan/callboard.git", branch: "main"

  depends_on "nielsmadan/tap/bellhop"
  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_equal "callboard #{version}", shell_output("#{bin}/callboard --version").strip
    assert_match "join callboard as a handle", shell_output("#{bin}/callboard --help")
  end
end
