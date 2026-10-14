# kube_exec is internal to source.modulotech.fr: its release binaries need a
# GitLab token with `read_api` scope, exported as HOMEBREW_GITLAB_TOKEN.
# Homebrew masks HOMEBREW_*TOKEN* variables while evaluating the formula and
# expands them only when downloading.
class KubeExec < Formula
  desc "Kubectl wrapper with per-cluster application autocompletion"
  homepage "https://source.modulotech.fr/modulosource/modulotech/devops/kube_exec"
  version "1.5.2"
  license :cannot_represent

  REGISTRY = "https://source.modulotech.fr/api/v4/projects/575/packages/generic/kube".freeze
  TOKEN_HEADER = "PRIVATE-TOKEN: #{ENV.fetch("HOMEBREW_GITLAB_TOKEN", "")}".freeze

  depends_on "int128/kubelogin/kubelogin"
  depends_on "jq"
  depends_on "kubernetes-cli"

  on_macos do
    on_arm do
      url "#{REGISTRY}/1.5.2/kube-darwin-arm64", header: TOKEN_HEADER
      sha256 "9a188382bc2f0ec869a173fdaa0d7f52f28632925fff94ebb329d745a6c04706"
    end
    on_intel do
      url "#{REGISTRY}/1.5.2/kube-darwin-amd64", header: TOKEN_HEADER
      sha256 "a6eac69ccbe2fbab3ca9be5e9d1ac6bf6ef14486a4a32f3d0b465e771514b548"
    end
  end

  on_linux do
    on_arm do
      url "#{REGISTRY}/1.5.2/kube-linux-arm64", header: TOKEN_HEADER
      sha256 "5107d3eb36d96b8ae8840672234520da3540dd66cf2721ec0afcee1fef57c2f1"
    end
    on_intel do
      url "#{REGISTRY}/1.5.2/kube-linux-amd64", header: TOKEN_HEADER
      sha256 "644772dda9972d48e213b3eeeb0f501cd2d5e0aba6b1c59ab21ea5d731c8c391"
    end
  end

  def install
    binary = Dir["kube-*"].first
    chmod 0755, binary
    bin.install binary => "kube"
    generate_completions_from_executable(bin/"kube", "completion", shells: [:bash, :zsh])
  end

  def caveats
    <<~EOS
      Downloading kube requires a source.modulotech.fr token with read_api scope:
        export HOMEBREW_GITLAB_TOKEN=<token>

      Upgrade with `brew upgrade kube-exec`, not `kube version upgrade`.

      Then initialise credentials:
        kube credential refresh
    EOS
  end

  test do
    assert_match "Current version: #{version}", shell_output("#{bin}/kube version")
  end
end
