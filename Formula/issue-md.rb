class IssueMd < Formula
  desc "Export a GitLab issue as clean Markdown"
  homepage "https://github.com/moduloTech/issue-md"
  url "https://github.com/moduloTech/issue-md/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "2a7c9b87af62b3331bfaace7ffa615675f0af19834fb76ae12851d243e6b9d6b"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/issue-md"
  end

  test do
    assert_match "issue-md #{version}", shell_output("#{bin}/issue-md --version")
  end
end
