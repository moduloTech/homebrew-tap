class DangerClaude < Formula
  desc "Run Claude Code CLI as a non-root user with sandboxed permissions"
  homepage "https://github.com/moduloTech/danger-claude"
  url "https://github.com/moduloTech/danger-claude/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "5e3be5bf4b262acd71f58e5d0fe042f0d6dced0f32010bad349d5ae7f312d148"
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
