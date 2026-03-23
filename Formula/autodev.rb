class Autodev < Formula
  desc "Automated GitLab issue implementation via danger-claude"
  homepage "https://github.com/moduloTech/autodev"
  url "https://github.com/moduloTech/autodev/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "e5bd52b46c86ae3ffd003580ab463cae0f99f5076a13e947427d755480a0bf65"
  license :cannot_represent

  depends_on "modulotech/tap/danger-claude"
  depends_on "modulotech/tap/mr-review"
  depends_on "ruby"

  def install
    bin.install "bin/autodev"
  end

  test do
    assert_match "usage", shell_output("#{bin}/autodev --help", 2).downcase
  end
end
