cask "gridsnap" do
  version "1.0.0"
  sha256 "3d19769b77bed2faaf2f63cffdc4fc3ea1763161eafa9c8880b3d438353bbe09"

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
