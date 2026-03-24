class DangerClaude < Formula
  desc "Run Claude Code CLI as a non-root user with sandboxed permissions"
  homepage "https://github.com/moduloTech/danger-claude"
  url "https://github.com/moduloTech/danger-claude/archive/refs/tags/v0.0.6.tar.gz"
  sha256 "3ea1c19fb75d39c1d6fc5923e58423f244266963adc62b1191e973190f51397c"
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
