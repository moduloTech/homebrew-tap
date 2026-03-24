class MrReview < Formula
  desc "Automated GitLab Merge Request review via Claude Code"
  homepage "https://github.com/moduloTech/mr-review"
  url "https://github.com/moduloTech/mr-review/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "68ae545bd7ee9878d27a5dbfcd4a81f17293cd69985a2b6b987a24107b80f866"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/mr-review"
  end

  test do
    assert_match "usage", shell_output("#{bin}/mr-review --help", 2).downcase
  end
end
