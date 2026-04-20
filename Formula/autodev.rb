class Autodev < Formula
  desc "Automated GitLab issue implementation via danger-claude"
  homepage "https://github.com/moduloTech/autodev"
  url "https://github.com/moduloTech/autodev/archive/refs/tags/v0.11.5.tar.gz"
  sha256 "51c3cd320029a2ed374dea516160bd9fa5a524c53e32b017663a957189994f3a"
  license :cannot_represent

  depends_on "modulotech/tap/danger-claude"
  depends_on "modulotech/tap/mr-review"
  depends_on "ruby"

  def install
    bin.install "bin/autodev"
    prefix.install "lib"
  end

  test do
    assert_match "autodev #{version}", shell_output("#{bin}/autodev --version")
  end
end
