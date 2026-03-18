class DangerClaude < Formula
  desc "Run Claude Code CLI as a non-root user with sandboxed permissions"
  homepage "https://github.com/moduloTech/danger-claude"
  url "https://github.com/moduloTech/danger-claude/archive/refs/tags/v0.0.2.2.tar.gz"
  sha256 "b89f986cfeeeef12d90dcae67616ee953f6d0052968080a2be070b4dc6125243"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/danger-claude"
  end

  test do
    assert_match "usage", shell_output("#{bin}/danger-claude --help", 2).downcase
  end
end
