cask "quickopen" do
  version "1.0.0"
  sha256 :no_check

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
