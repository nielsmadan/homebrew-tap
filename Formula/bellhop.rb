class Bellhop < Formula
  include Language::Python::Virtualenv

  desc "Deliver a message into a running coding-agent session"
  homepage "https://github.com/nielsmadan/bellhop"
  url "https://github.com/nielsmadan/bellhop/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "a75d4508149770422e9b65fb64b8caebb8592bf6b6a62aca27165a744ae2226b"
  license "MIT"
  head "https://github.com/nielsmadan/bellhop.git", branch: "main"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_equal "bellhop #{version}", shell_output("#{bin}/bellhop --version").strip
    system bin/"bellhop", "integration", "export", "skill", "--to", testpath/"skills"
    assert_path_exists testpath/"skills/bellhop/SKILL.md"
    system bin/"bellhop", "integration", "export", "pi", "--to", testpath/"extensions"
    assert_path_exists testpath/"extensions/bellhop.ts"
  end
end
