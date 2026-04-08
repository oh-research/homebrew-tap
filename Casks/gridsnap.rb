cask "gridsnap" do
  version "1.0.3"
  sha256 "2d2aeaa9f74b61de9a7ac774f2975e1503ec8f3ce6c706651f9d21621c86de33"

  url "https://github.com/oh-research/GridSnap/releases/download/v#{version}/gridsnap-#{version}.dmg"
  name "GridSnap"
  desc "Snap windows to a custom grid with Shift + drag"
  homepage "https://github.com/oh-research/GridSnap"

  depends_on macos: ">= :sequoia"

  app "GridSnap.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/GridSnap.app"]
    system_command "/usr/bin/open",
                   args: ["#{appdir}/GridSnap.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.ohresearch.gridsnap.plist",
  ]
end
