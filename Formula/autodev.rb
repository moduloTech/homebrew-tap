class Autodev < Formula
  desc "Automated GitLab issue implementation via danger-claude"
  homepage "https://github.com/moduloTech/autodev"
  url "https://github.com/moduloTech/autodev/archive/refs/tags/v0.14.1.tar.gz"
  sha256 "22d9ed393bac93dfbec038785768d6e43de449b605221e616c671af2ee788ab0"
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
