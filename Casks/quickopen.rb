cask "quickopen" do
  version "1.0.3"
  sha256 "2c742de0509ea5bbc533185d3a0044d107c8e2c34f94eafbc4dc972db19456d5"

  url "https://github.com/oh-research/QuickOpen/releases/download/v#{version}/quickopen-#{version}.dmg"
  name "QuickOpen"
  desc "Open Finder files and folders in any app with shortcuts, clicks, or gestures"
  homepage "https://github.com/oh-research/QuickOpen"

  depends_on macos: ">= :sonoma"

  app "QuickOpen.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/QuickOpen.app"]
    system_command "/usr/bin/open",
                   args: ["#{appdir}/QuickOpen.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.ohresearch.QuickOpen.plist",
  ]
end
