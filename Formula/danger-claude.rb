class DangerClaude < Formula
  desc "Run Claude Code CLI as a non-root user with sandboxed permissions"
  homepage "https://github.com/moduloTech/danger-claude"
  url "https://github.com/moduloTech/danger-claude/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "accd46e80ac4ff76fe4662ff191a6118e1b1598bbf44295eb928497917f9d3e6"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/danger-claude"
  end

  test do
    assert_match "usage", shell_output("#{bin}/danger-claude --help", 2).downcase
  end
end
