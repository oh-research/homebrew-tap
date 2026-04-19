cask "screendial" do
  version "0.3.0"
  sha256 "0e631dd26beb5953d752c60dc605406d62b153523e8919ea8169a3823346e739"

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
