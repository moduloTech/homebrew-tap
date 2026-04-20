class Autodev < Formula
  desc "Automated GitLab issue implementation via danger-claude"
  homepage "https://github.com/moduloTech/autodev"
  url "https://github.com/moduloTech/autodev/archive/refs/tags/v0.11.2.tar.gz"
  sha256 "19dbb09d41d7dfd7126ae07544c998df180ecae5ff1c2fed8e6638702ee68c1a"
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
