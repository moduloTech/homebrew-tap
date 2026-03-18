# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://docs.brew.sh/rubydoc/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class DangerClaude < Formula
  desc "Run Claude Code CLI as a non-root user with sandboxed permissions"
  homepage "https://github.com/moduloTech/danger-claude"
  url "https://github.com/moduloTech/danger-claude/archive/refs/tags/v0.0.1.tar.gz"
  version "0.0.1"
  sha256 "66aa0e852f3e847e9aefb3b63596631e7ea8e5cd273ec8f953aa3a8a904ce4ff"
  license :cannot_represent

  depends_on "ruby"

  def install
    bin.install "bin/danger-claude"
  end

  test do
    assert_match "usage", shell_output("#{bin}/danger-claude --help", 2).downcase
  end
end
