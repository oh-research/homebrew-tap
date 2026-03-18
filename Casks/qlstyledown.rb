cask "qlstyledown" do
  version "1.0.0"
  sha256 "a8e874db4b2bac0605d431b93d8efc044e3cc46fb0f7e484f3c3e369e6eb0165"

  url "https://github.com/oh-research/QLStyledown/releases/download/v#{version}/qlstyledown-#{version}.dmg"
  name "qlstyledown"
  desc "CSS-customizable Markdown renderer for Quick Look"
  homepage "https://github.com/oh-research/QLStyledown"

  depends_on macos: ">= :sequoia"

  app "qlstyledown.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/qlstyledown.app"]
    system_command "/bin/ln",
                   args: ["-sf",
                          "#{appdir}/qlstyledown.app/Contents/MacOS/qlstyledown-cli",
                          "#{HOMEBREW_PREFIX}/bin/qlstyledown"]
    system_command "/usr/bin/open",
                   args: ["#{appdir}/qlstyledown.app"]
  end

  uninstall script: {
              executable: "/usr/bin/pluginkit",
              args:       ["-e", "ignore", "-i", "com.ohresearch.qlstyledown.qlstyledownPreview"],
            },
            delete: "#{HOMEBREW_PREFIX}/bin/qlstyledown"

  zap trash: "~/.qlstyledown"

  caveats <<~EOS
    앱을 한 번 실행하면 Quick Look Extension이 등록됩니다.
  EOS
end
