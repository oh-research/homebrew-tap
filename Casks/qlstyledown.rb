cask "qlstyledown" do
  version "1.0.0"
  sha256 "0f9021974bac5f05f8c90ea9cb4cd402dc6ee9f14a81850ea7ad300d0c886d8c"

  url "https://github.com/oh-research/QLStyledown/releases/download/v#{version}/qlstyledown-#{version}.dmg"
  name "qlstyledown"
  desc "CSS-customizable Markdown renderer for Quick Look"
  homepage "https://github.com/oh-research/QLStyledown"

  depends_on macos: ">= :ventura"

  app "qlstyledown.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/qlstyledown.app"]
    system_command "/bin/ln",
                   args: ["-sf",
                          "#{appdir}/qlstyledown.app/Contents/MacOS/qlstyledown-cli",
                          "#{HOMEBREW_PREFIX}/bin/qlstyledown"]
    # 기본 테마 설치 (이미 있으면 덮어쓰지 않음)
    themes_dir = "#{Dir.home}/.qlstyledown/themes"
    system_command "/bin/mkdir",
                   args: ["-p", themes_dir]
    # default.css → github.css
    github_dest = "#{themes_dir}/github.css"
    unless File.exist?(github_dest)
      system_command "/bin/cp",
                     args: ["#{appdir}/qlstyledown.app/Contents/Resources/default.css", github_dest]
    end
    %w[lapis minimal monokai nord solarized-light tailwind warp-gradient].each do |theme|
      src = "#{appdir}/qlstyledown.app/Contents/Resources/#{theme}.css"
      dest = "#{themes_dir}/#{theme}.css"
      unless File.exist?(dest)
        system_command "/bin/cp",
                       args: [src, dest] if File.exist?(src)
      end
    end
    # 앱 실행 (Extension 등록 + 글로벌 CSS 초기화)
    system_command "/usr/bin/open",
                   args: ["#{appdir}/qlstyledown.app"]
    system_command "/bin/sleep",
                   args: ["3"]
    system_command "/usr/bin/pluginkit",
                   args: ["-e", "use", "-i", "com.ohresearch.qlstyledown.qlstyledownPreview"]
    system_command "/usr/bin/qlmanage",
                   args: ["-r"]
  end

  uninstall script: [
              {
                executable: "/usr/bin/pluginkit",
                args:       ["-e", "ignore", "-i", "com.ohresearch.qlstyledown.qlstyledownPreview"],
              },
              {
                executable: "/usr/bin/pluginkit",
                args:       ["-r", "#{appdir}/qlstyledown.app/Contents/PlugIns/qlstyledownPreview.appex"],
              },
            ],
            delete: "#{HOMEBREW_PREFIX}/bin/qlstyledown"

  zap trash: "~/.qlstyledown"

end
