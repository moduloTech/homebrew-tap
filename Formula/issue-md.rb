class IssueMd < Formula
  desc "Export a GitLab issue as clean Markdown"
  homepage "https://github.com/moduloTech/issue-md"
  url "https://github.com/moduloTech/issue-md/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "db923822615f10284c8b6b49a69440fa3535c9a9ed3c395d62a2cc2174dbe298"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/issue-md"
  end

  test do
    assert_match "issue-md #{version}", shell_output("#{bin}/issue-md --version")
  end
end
