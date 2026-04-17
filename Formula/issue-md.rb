class IssueMd < Formula
  desc "Export a GitLab issue as clean Markdown"
  homepage "https://github.com/moduloTech/issue-md"
  url "https://github.com/moduloTech/issue-md/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f88244170b57b1b15aa52e28571816f3bea96792d8236987fa68f8b2b5aa2351"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/issue-md"
  end

  test do
    assert_match "issue-md #{version}", shell_output("#{bin}/issue-md --version")
  end
end
