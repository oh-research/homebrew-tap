cask "qlstyledown" do
  version "1.0.0"
  sha256 "e92d032fad65d1a7aadf37d8612a07caa5679e33fce5c805a2fc9a87b9b0a440"

  url "https://github.com/oh-research/QLStyledown/releases/download/v#{version}/qlstyledown-1.0.dmg"
  name "qlstyledown"
  desc "CSS-customizable Markdown renderer for Quick Look"
  homepage "https://github.com/oh-research/QLStyledown"

  depends_on macos: ">= :sequoia"

  app "qlstyledown.app"

  postflight do
    system_command "/usr/bin/ln",
                   args: ["-sf",
                          "#{appdir}/qlstyledown.app/Contents/MacOS/qlstyledown-cli",
                          "/usr/local/bin/qlstyledown"]
  end

  uninstall delete: "/usr/local/bin/qlstyledown"

  zap trash: "~/.qlstyledown"

  caveats <<~EOS
    서명되지 않은 앱이므로 최초 실행 전 격리 플래그를 제거해야 합니다:
      xattr -cr /Applications/qlstyledown.app
    앱을 한 번 실행하면 Quick Look Extension이 등록됩니다.
  EOS
end
