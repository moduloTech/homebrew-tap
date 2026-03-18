class DangerClaude < Formula
  desc "Run Claude Code CLI as a non-root user with sandboxed permissions"
  homepage "https://github.com/moduloTech/danger-claude"
  url "https://github.com/moduloTech/danger-claude/archive/refs/tags/v0.0.2.4.tar.gz"
  sha256 "4eccee83a5e9e0c1bc07b41af5d19455a069f7dad5c8fb2c34bab7a3691c501a"
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
