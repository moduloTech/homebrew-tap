class MrReview < Formula
  desc "Automated GitLab Merge Request review via Claude Code"
  homepage "https://github.com/moduloTech/mr-review"
  url "https://github.com/moduloTech/mr-review/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "7163bb0cc32d86aaed883568e4a4bee582b7ea1b0860b17ad6a2f105a3aaa3c0"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/mr-review"
  end

  test do
    assert_match "usage", shell_output("#{bin}/mr-review --help", 2).downcase
  end
end
