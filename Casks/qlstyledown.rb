cask "qlstyledown" do
  version "1.0.0"
  sha256 "d255d5f43363f605c5143f4b230363780308b72e136de78c67a715db6702aacb"

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
    # 기본 테마 설치
    system_command "/bin/mkdir",
                   args: ["-p", "#{Dir.home}/.qlstyledown/themes"]
    # default.css → github.css로 복사
    system_command "/bin/cp",
                   args: ["-n",
                          "#{appdir}/qlstyledown.app/Contents/Resources/default.css",
                          "#{Dir.home}/.qlstyledown/themes/github.css"]
    %w[lapis minimal monokai nord solarized-light tailwind warp-gradient].each do |theme|
      src = "#{appdir}/qlstyledown.app/Contents/Resources/#{theme}.css"
      dest = "#{Dir.home}/.qlstyledown/themes/#{theme}.css"
      system_command "/bin/cp",
                     args: ["-n", src, dest] if File.exist?(src)
    end
    # 앱 실행 (Extension 등록 + 글로벌 CSS 초기화)
    system_command "/usr/bin/open",
                   args: ["#{appdir}/qlstyledown.app"]
    system_command "/usr/bin/pluginkit",
                   args: ["-e", "use", "-i", "com.ohresearch.qlstyledown.qlstyledownPreview"]
    system_command "/usr/bin/qlmanage",
                   args: ["-r"]
  end

  uninstall script: {
              executable: "/usr/bin/pluginkit",
              args:       ["-e", "ignore", "-i", "com.ohresearch.qlstyledown.qlstyledownPreview"],
            },
            delete: "#{HOMEBREW_PREFIX}/bin/qlstyledown"

  zap trash: "~/.qlstyledown"

end
