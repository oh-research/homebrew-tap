cask "screendial" do
  version "0.1.0"
  sha256 "bb784fe59b002011fd64780f1904da1cea80da348a7e546a9e4f6382580ee80e"

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
