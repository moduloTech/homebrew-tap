class Autodev < Formula
  desc "Automated GitLab issue implementation via danger-claude"
  homepage "https://github.com/moduloTech/autodev"
  url "https://github.com/moduloTech/autodev/archive/refs/tags/v1.0.0-alpha.1.tar.gz"
  version "1.0.0-alpha.1"
  sha256 "5fa00767f0e7d9c24f1e167717c205b4f8646aa12785fe3b1f62943465395121"
  license :cannot_represent

  depends_on "modulotech/tap/danger-claude"
  depends_on "modulotech/tap/mr-review"
  depends_on "ruby"
  depends_on "sqlite"

  def install
    # autodev is a Rails 8 application as of v1.0.0-alpha.1, not a single
    # bundler/inline script. Install the whole repo into libexec, run
    # `bundle install --deployment` to materialise vendor/bundle/, then
    # expose `bin/autodev` via a symlink in Brew's bin/.
    libexec.install Dir["*"]

    cd libexec do
      ENV["BUNDLE_GEMFILE"] = "#{libexec}/Gemfile"
      ENV.delete("RUBYOPT") # avoid pulling in bundler from outside
      system "bundle", "config", "set", "--local", "path", "vendor/bundle"
      system "bundle", "config", "set", "--local", "deployment", "true"
      system "bundle", "config", "set", "--local", "without", "development:test"
      system "bundle", "install", "--jobs", "4", "--retry", "3"
    end

    # The symlinked `autodev` resolves __FILE__ → __dir__ to libexec/bin/,
    # so `require_relative '../config/environment'` and `../Gemfile`
    # land in the right place.
    bin.install_symlink libexec/"bin/autodev"
  end

  def caveats
    <<~EOS
      autodev v1.0.0-alpha.1 boots a Rails app. State (config, SQLite DBs,
      logs) lives under `~/.autodev/`:

        ~/.autodev/config.yml         project + GitLab credentials
        ~/.autodev/autodev.db         business data (issues, activity)
        ~/.autodev/autodev_queue.db   Solid Queue tables (auto-created)
        ~/.autodev/log/<env>.log      Rails log
        ~/.autodev/tmp/               Rails tmp

      Set AUTODEV_HOME to relocate everything (e.g. for a service account).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autodev --version")
  end
end
