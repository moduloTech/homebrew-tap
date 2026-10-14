# kube_exec is internal to source.modulotech.fr: its release binaries need a
# GitLab token with `read_api` scope, exported as HOMEBREW_GITLAB_TOKEN.
# Homebrew masks HOMEBREW_*TOKEN* variables while evaluating the formula and
# expands them only when downloading.
class KubeExec < Formula
  desc "Kubectl wrapper with per-cluster application autocompletion"
  homepage "https://source.modulotech.fr/modulosource/modulotech/devops/kube_exec"
  version "1.5.1"
  license :cannot_represent

  REGISTRY = "https://source.modulotech.fr/api/v4/projects/575/packages/generic/kube".freeze
  TOKEN_HEADER = "PRIVATE-TOKEN: #{ENV.fetch("HOMEBREW_GITLAB_TOKEN", "")}".freeze

  depends_on "int128/kubelogin/kubelogin"
  depends_on "jq"
  depends_on "kubernetes-cli"

  on_macos do
    on_arm do
      url "#{REGISTRY}/1.5.1/kube-darwin-arm64", header: TOKEN_HEADER
      sha256 "a992ba8953f14932baffe8786c66479fed49a9fedc064f3d744b3c4fb9265e37"
    end
    on_intel do
      url "#{REGISTRY}/1.5.1/kube-darwin-amd64", header: TOKEN_HEADER
      sha256 "3ef5d1481ed9fdfa318ce438160e8ae2cd3df0c4d48b045c95ac6ee589101f33"
    end
  end

  # The released kube-linux-arm64 is an x86-64 binary, so Linux ARM is not offered.
  on_linux do
    on_intel do
      url "#{REGISTRY}/1.5.1/kube-linux-amd64", header: TOKEN_HEADER
      sha256 "4b72076e6b38b169677ddfa6a4a481e08a100ec77ced96aecb9e4c82b46ebf6e"
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
