class Wtclone < Formula
  desc "Bootstrap a git repository in worktree layout (bare + pointer + initial worktree)"
  homepage "https://github.com/moduloTech/wtclone"
  url "https://github.com/moduloTech/wtclone/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "c34b53f8cfadcd32ba7b51f8254d967d469028a30689fa741e5920212ab7dab4"
  license :cannot_represent

  def install
    bin.install "bin/wtclone"
  end

  test do
    assert_match "usage", shell_output("#{bin}/wtclone --help").downcase
  end
end
