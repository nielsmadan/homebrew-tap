class Splashdown < Formula
  include Language::Python::Virtualenv

  desc "Per-checkout resource provisioner: sims, ports, env templates for git worktrees"
  homepage "https://github.com/nielsmadan/splashdown"
  url "https://github.com/nielsmadan/splashdown/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "0bd39cfcb0434b68b4d0b8e7b14f44e5c84b304cce2f0e0bfc745fa9e34c1ae5"
  license "MIT"
  head "https://github.com/nielsmadan/splashdown.git", branch: "main"

  depends_on "python@3.13"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Per-checkout resource provisioner", shell_output("#{bin}/splash --help")
    Dir.chdir(testpath) do
      system "git", "init", "-q"
      system bin/"splash", "init", "--preset=minimal"
      assert_predicate testpath/"splashdown.toml", :exist?
      ENV["XDG_STATE_HOME"] = (testpath/"state").to_s
      system bin/"splash"
      assert_predicate testpath/"splashdown.env", :exist?
    end
  end
end
