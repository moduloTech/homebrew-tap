class Autodev < Formula
  desc "Automated GitLab issue implementation via danger-claude"
  homepage "https://github.com/moduloTech/autodev"
  url "https://github.com/moduloTech/autodev/archive/refs/tags/v0.6.3.tar.gz"
  sha256 "8b3e097b915a7d295ab16f3f312db3243d332b1c7cf1837f2cf0393e42a341df"
  license :cannot_represent

  depends_on "modulotech/tap/danger-claude"
  depends_on "modulotech/tap/mr-review"
  depends_on "ruby"

  def install
    bin.install "bin/autodev"
    prefix.install "lib"
  end

  test do
    assert_match "usage", shell_output("#{bin}/autodev --help", 2).downcase
  end
end
