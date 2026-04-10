class Autodev < Formula
  desc "Automated GitLab issue implementation via danger-claude"
  homepage "https://github.com/moduloTech/autodev"
  url "https://github.com/moduloTech/autodev/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "70bbc3e3ffd1363e70b5772abb3540a7c796508ea105e51f02e8b20bc9ca1478"
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
