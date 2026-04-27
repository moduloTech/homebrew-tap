class DangerClaude < Formula
  desc "Run Claude Code CLI as a non-root user with sandboxed permissions"
  homepage "https://github.com/moduloTech/danger-claude"
  url "https://github.com/moduloTech/danger-claude/archive/refs/tags/v0.5.3.tar.gz"
  sha256 "9a4b092c983f9ee165d948fa8d0c13ec0b612cc358942b443766ce38f38a92f1"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/danger-claude"
    prefix.install "Dockerfile"
  end

  test do
    assert_match "usage", shell_output("#{bin}/danger-claude --help", 2).downcase
  end
end
