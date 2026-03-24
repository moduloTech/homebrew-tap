class Autodev < Formula
  desc "Automated GitLab issue implementation via danger-claude"
  homepage "https://github.com/moduloTech/autodev"
  url "https://github.com/moduloTech/autodev/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "0ad8205bbbce593c067ddeb5d469c0dfe72f01f7b396b0268c980d38b702ac7c"
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
