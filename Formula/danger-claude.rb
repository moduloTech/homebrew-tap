class DangerClaude < Formula
  desc "Run Claude Code CLI as a non-root user with sandboxed permissions"
  homepage "https://github.com/moduloTech/danger-claude"
  url "https://github.com/moduloTech/danger-claude/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "3ce08c32201364313f080fde06d434e0fa8f2547ad3036f0b191463893a11099"
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
