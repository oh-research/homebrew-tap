cask "qlstyledown" do
  version "1.0.3"
  sha256 "62a926685b8bd49d986716efdd48e0582f9bd8337821f0476d665c0157b37d79"

  url "https://github.com/oh-research/QLStyledown/releases/download/v#{version}/qlstyledown-#{version}.dmg"
  name "qlstyledown"
  desc "CSS-customizable Markdown renderer for Quick Look"
  homepage "https://github.com/oh-research/QLStyledown"

  depends_on macos: ">= :sequoia"

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
    # Force LaunchServices to register the app and its UTI declarations.
    # Required on macOS 15 — `open` alone does not always trigger UTI registration on first install.
    system_command "/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister",
                   args: ["-f", "#{appdir}/QLStyledown.app"]
    # 앱 실행 (Extension 등록 + 글로벌 CSS 초기화)
    system_command "/usr/bin/open",
                   args: ["#{appdir}/QLStyledown.app"]
    system_command "/bin/sleep",
                   args: ["3"]
    system_command "/usr/bin/pluginkit",
                   args: ["-e", "use", "-i", "com.ohresearch.qlstyledown.qlstyledownPreview"]
    system_command "/usr/bin/qlmanage",
                   args: ["-r"]
    system_command "/usr/bin/qlmanage",
                   args: ["-r", "cache"]
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
