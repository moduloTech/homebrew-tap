class DangerClaude < Formula
  desc "Run Claude Code CLI as a non-root user with sandboxed permissions"
  homepage "https://github.com/moduloTech/danger-claude"
  url "https://github.com/moduloTech/danger-claude/archive/refs/tags/v0.0.2.1.tar.gz"
  sha256 "66884a678b948d1aa926239fa81b12e65f1e27894798d70d6ee82c96caf3cce0"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/danger-claude"
  end

  test do
    assert_match "usage", shell_output("#{bin}/danger-claude --help", 2).downcase
  end
end
