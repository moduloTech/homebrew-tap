class Autodev < Formula
  desc "Automated GitLab issue implementation via danger-claude"
  homepage "https://github.com/moduloTech/autodev"
  url "https://github.com/moduloTech/autodev/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "4ed991b11966fc677f383cf4338723bad5d6f9e29827b9a04aebfbfe26ccb074"
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
