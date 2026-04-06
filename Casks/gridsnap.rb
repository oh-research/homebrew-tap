cask "gridsnap" do
  version "1.0.1"
  sha256 "b6e76876a73f4656a6627206cd0afecb8221e12f904d89f26b2d4660a369ca01"

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
