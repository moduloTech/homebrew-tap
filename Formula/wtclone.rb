class Wtclone < Formula
  desc "Bootstrap a git repository in worktree layout (bare + pointer + initial worktree)"
  homepage "https://github.com/moduloTech/wtclone"
  url "https://github.com/moduloTech/wtclone/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "5a9aea635d90a323419a4a7f35029158c4e555c720417ea9eec4f8e69be873f8"
  license :cannot_represent

  def install
    bin.install "bin/wtclone"
  end

  test do
    assert_match "usage", shell_output("#{bin}/wtclone --help").downcase
  end
end
