class Autodev < Formula
  desc "Automated GitLab issue implementation via danger-claude"
  homepage "https://github.com/moduloTech/autodev"
  url "https://github.com/moduloTech/autodev/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "1b708eb01898a0fb33a4917d155564a47981997da729debefdad13ba4c0fe12d"
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
