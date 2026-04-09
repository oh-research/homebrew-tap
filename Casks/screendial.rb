cask "screendial" do
  version "0.1.0"
  sha256 "6fb9b61db21caacba66887c6c1149f8a14361854732788127a55954162aa9f85"

  url "https://github.com/oh-research/ScreenDial/releases/download/v#{version}/screendial-#{version}.dmg"
  name "ScreenDial"
  desc "One-click display presets for brightness, color temperature, and appearance mode"
  homepage "https://github.com/oh-research/ScreenDial"

  depends_on macos: ">= :sequoia"

  app "ScreenDial.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ScreenDial.app"]
    system_command "/usr/bin/open",
                   args: ["#{appdir}/ScreenDial.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.ohresearch.screendial.plist",
    "~/Library/Application Support/ScreenDial",
  ]
end
