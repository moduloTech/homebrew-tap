class MrReview < Formula
  desc "Automated GitLab Merge Request review via Claude Code"
  homepage "https://github.com/moduloTech/mr-review"
  url "https://github.com/moduloTech/mr-review/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "4d824459db5bc7983d5db0f878ce501f0a3ac7b777d97cbe30039595655d3095"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/mr-review"
  end

  test do
    assert_match "usage", shell_output("#{bin}/mr-review --help", 2).downcase
  end
end
