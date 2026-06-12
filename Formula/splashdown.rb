class Splashdown < Formula
  include Language::Python::Virtualenv

  desc "Per-checkout resource provisioner: sims, ports, env templates for git worktrees"
  homepage "https://github.com/nielsmadan/splashdown"
  url "https://github.com/nielsmadan/splashdown/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "6abaf921a8f82eb493873dda9ff85f3e4c12ce64c1d745e521f91e44d70c1c5e"
  license "MIT"
  head "https://github.com/nielsmadan/splashdown.git", branch: "main"

  depends_on "python@3.13"

  resource "argcomplete" do
    url "https://files.pythonhosted.org/packages/38/61/0b9ae6399dd4a58d8c1b1dc5a27d6f2808023d0b5dd3104bb99f45a33ff6/argcomplete-3.6.3.tar.gz"
    sha256 "6abaf921a8f82eb493873dda9ff85f3e4c12ce64c1d745e521f91e44d70c1c5e"
  end

  def install
    virtualenv_install_with_resources
    # Generate static shell completions from argcomplete's registration script.
    # The bash/zsh output calls back into `splash`, so dynamic completion (device
    # variants) still works at runtime.
    generate_completions_from_executable(
      libexec/"bin/register-python-argcomplete", "splash",
      shell_parameter_format: :arg, base_name: "splash", shells: [:bash, :zsh]
    )
  end

  test do
    assert_match "Per-checkout resource provisioner", shell_output("#{bin}/splash --help")
    Dir.chdir(testpath) do
      system "git", "init", "-q"
      system bin/"splash", "init", "minimal"
      assert_predicate testpath/"splashdown.toml", :exist?
      ENV["XDG_STATE_HOME"] = (testpath/"state").to_s
      system bin/"splash"
      assert_predicate testpath/"splashdown.env", :exist?
    end
  end
end
