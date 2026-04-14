class MrReview < Formula
  desc "Automated GitLab Merge Request review via Claude Code"
  homepage "https://github.com/moduloTech/mr-review"
  url "https://github.com/moduloTech/mr-review/archive/refs/tags/v0.3.3.tar.gz"
  sha256 "b27d1a848510af2bfc242fae9f8123467f9390d70022e34d40db5f34d592a53d"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/mr-review"
  end

  test do
    assert_match "usage", shell_output("#{bin}/mr-review --help", 2).downcase
  end
end
