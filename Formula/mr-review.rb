class MrReview < Formula
  desc "Automated GitLab Merge Request review via Claude Code"
  homepage "https://github.com/moduloTech/mr-review"
  url "https://github.com/moduloTech/mr-review/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d70d457a35b3e6586aef9d8702d595054edb1f4c318200dda881cf4d85e7d182"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/mr-review"
  end

  test do
    assert_match "usage", shell_output("#{bin}/mr-review --help", 2).downcase
  end
end
