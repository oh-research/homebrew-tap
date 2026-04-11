cask "qlstyledown" do
  version "1.0.2"
  sha256 "5dfd2da2ef177e42920752a328df1d28a6d590808aae649a7c2b0a01c38078c9"

  url "https://github.com/oh-research/QLStyledown/releases/download/v#{version}/qlstyledown-#{version}.dmg"
  name "qlstyledown"
  desc "CSS-customizable Markdown renderer for Quick Look"
  homepage "https://github.com/oh-research/QLStyledown"

  depends_on macos: ">= :tahoe"

  app "QLStyledown.app"
  binary "#{appdir}/QLStyledown.app/Contents/MacOS/qlstyledown-cli", target: "qlstyledown"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/QLStyledown.app"]
    # 기본 테마 설치 (이미 있으면 덮어쓰지 않음)
    themes_dir = "#{Dir.home}/.qlstyledown/themes"
    system_command "/bin/mkdir",
                   args: ["-p", themes_dir]
    # default.css → github.css
    github_dest = "#{themes_dir}/github.css"
    unless File.exist?(github_dest)
      system_command "/bin/cp",
                     args: ["#{appdir}/QLStyledown.app/Contents/Resources/default.css", github_dest]
    end
    %w[lapis minimal monokai nord solarized-light tailwind warp-gradient].each do |theme|
      src = "#{appdir}/QLStyledown.app/Contents/Resources/#{theme}.css"
      dest = "#{themes_dir}/#{theme}.css"
      if File.exist?(src) && !File.exist?(dest)
        system_command "/bin/cp",
                       args: [src, dest]
      end
    end
    # 앱 실행 (Extension 등록 + 글로벌 CSS 초기화)
    system_command "/usr/bin/open",
                   args: ["#{appdir}/QLStyledown.app"]
    system_command "/bin/sleep",
                   args: ["3"]
    system_command "/usr/bin/pluginkit",
                   args: ["-e", "use", "-i", "com.ohresearch.qlstyledown.qlstyledownPreview"]
    system_command "/usr/bin/qlmanage",
                   args: ["-r"]
  end

  uninstall_preflight do
    system_command "/usr/bin/pluginkit",
                   args: ["-e", "ignore", "-i", "com.ohresearch.qlstyledown.qlstyledownPreview"]
  end

  zap trash: [
    "~/.qlstyledown",
    "~/Library/Application Scripts/com.ohresearch.qlstyledown",
    "~/Library/Application Scripts/com.ohresearch.qlstyledown.qlstyledownPreview",
    "~/Library/Containers/com.ohresearch.qlstyledown",
    "~/Library/Containers/com.ohresearch.qlstyledown.qlstyledownPreview",
    "~/Library/Group Containers/group.com.ohresearch.qlstyledown",
  ]
end
