cask "gridsnap" do
  version "1.0.0"
  sha256 "661f23ddcdf8963713b96935e4f406c5b51a4442285d5153ec99c5769b696852"

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
