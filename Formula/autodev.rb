class Autodev < Formula
  desc "Automated GitLab issue implementation via danger-claude"
  homepage "https://github.com/moduloTech/autodev"
  url "https://github.com/moduloTech/autodev/archive/refs/tags/v0.8.4.tar.gz"
  sha256 "2b40f67f82f64b338242e7bd2ee28db32a5cb4e03272566de84cbee0c171a60e"
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
