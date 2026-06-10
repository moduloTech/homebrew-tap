class Autodev < Formula
  desc "Automated GitLab issue implementation via danger-claude"
  homepage "https://github.com/moduloTech/autodev"
  url "https://github.com/moduloTech/autodev/archive/refs/tags/v1.0.0-alpha.13.tar.gz"
  version "1.0.0-alpha.13"
  sha256 "06a6005142a991a02d0ae1e34383bbed094a40f45dc24e917189c98a515a2a91"
  license :cannot_represent

  depends_on "modulotech/tap/danger-claude"
  depends_on "modulotech/tap/mr-review"
  depends_on "ruby"
  depends_on "sqlite"

  def install
    # autodev is a Rails 8 application as of v1.0.0-alpha.1, not a single
    # bundler/inline script. Install the whole repo into libexec, run
    # `bundle install --deployment` to materialise vendor/bundle/, then
    # expose `bin/autodev` via a shell wrapper in Brew's bin/.
    libexec.install Dir["*"]

    cd libexec do
      ENV["BUNDLE_GEMFILE"] = "#{libexec}/Gemfile"
      ENV.delete("RUBYOPT") # avoid pulling in bundler from outside
      system "bundle", "config", "set", "--local", "path", "vendor/bundle"
      system "bundle", "config", "set", "--local", "deployment", "true"
      system "bundle", "config", "set", "--local", "without", "development:test"
      system "bundle", "install", "--jobs", "4", "--retry", "3"
    end

    # We CANNOT use `bin.install_symlink libexec/"bin/autodev"`. The
    # symlinked entry resolves `#!/usr/bin/env ruby` against PATH at run
    # time — on a machine with mise / rbenv / asdf shimming Ruby ahead of
    # /opt/homebrew/opt/ruby/bin, the script picks up a different Ruby
    # than the one `bundle install` linked the native gems against
    # (sqlite3.bundle, date.bundle, etc.), and Rails dies with
    # "linked to incompatible libruby.X.Y.dylib".
    #
    # Instead, write a shell wrapper that pins Brew's Ruby on PATH and
    # exec's libexec/bin/autodev. Child processes spawned by the autodev
    # supervisor (bin/rails server + bin/jobs) inherit the env, so their
    # own `#!/usr/bin/env ruby` shebangs also resolve to Brew's Ruby.
    # PATH composition for the wrapper:
    #   Formula["ruby"].opt_bin  — Brew Ruby first (ABI pin, see above).
    #   HOMEBREW_PREFIX/bin      — danger-claude, mr-review, sqlite, etc.
    #   HOMEBREW_PREFIX/sbin     — same family, less-common tools.
    #   /usr/local/bin           — Docker Desktop's symlink (lives here
    #                              even on Apple Silicon), legacy x86 Brew.
    #   /usr/local/sbin
    #   /usr/bin:/usr/sbin:/bin:/sbin — system tools (git, sh, ssh, env, ...).
    #   $PATH                    — preserved last so foreground invocations
    #                              still see whatever the user had in scope.
    #
    # Under launchd (`brew services start`) the inherited $PATH is
    # minimal — we can't rely on the user's shell rcs putting anything
    # on PATH — so the wrapper has to cover every directory the
    # workflow classes might shell out to (docker, gh, jq, ...). The
    # set above is what's reachable on a stock macOS + Brew + Docker
    # Desktop install.
    (bin/"autodev").write <<~SH
      #!/bin/bash
      export PATH="#{Formula["ruby"].opt_bin}:#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$PATH"
      exec "#{libexec}/bin/autodev" "$@"
    SH
    (bin/"autodev").chmod 0o755
  end

  service do
    run opt_bin/"autodev"
    keep_alive crashed: true
    log_path "#{Dir.home}/.autodev/log/autodev-stdout.log"
    error_log_path "#{Dir.home}/.autodev/log/autodev-stderr.log"
    working_dir Dir.home
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

      Start in the background:
        brew services start autodev      # supervised via launchd
        autodev                          # foreground in this shell

      The Ruby that runs autodev is `brew --prefix ruby`'s, NOT mise/rbenv/asdf
      — the bundler installed native gems against that ABI and a mismatch is
      fatal. The shell wrapper at #{HOMEBREW_PREFIX}/bin/autodev pins it.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/autodev --version")
  end
end
