cask "screendial" do
  version "1.0.1"
  sha256 "0739850ab855ad85d29abe619cf1712ed48202379ad9cd579ea78b0349d12635"

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
