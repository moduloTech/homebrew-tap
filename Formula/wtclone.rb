class Wtclone < Formula
  desc "Bootstrap a git repository in worktree layout (bare + pointer + initial worktree)"
  homepage "https://github.com/moduloTech/wtclone"
  url "https://github.com/moduloTech/wtclone/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8c1a649c656f3e347697a95e0ed624432bc4058d9c522b4833c3ffb9edec2d89"
  license :cannot_represent

  def install
    bin.install "bin/wtclone"
  end

  test do
    assert_match "usage", shell_output("#{bin}/wtclone --help").downcase
  end
end
