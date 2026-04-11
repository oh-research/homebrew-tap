cask "sniq" do
  version "1.1.0"
  sha256 "8700faa63fe473ec2fe805ce18949c4728cb7286fd5ee53f198015a62268849d"

  url "https://github.com/oh-research/Sniq/releases/download/v#{version}/sniq-#{version}.dmg"
  name "Sniq"
  desc "Snap windows to a custom grid with Shift + drag"
  homepage "https://github.com/oh-research/Sniq"

  depends_on macos: ">= :sequoia"

  app "Sniq.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Sniq.app"]
    system_command "/usr/bin/open",
                   args: ["#{appdir}/Sniq.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.ohresearch.sniq.plist",
    "~/Library/Application Support/Sniq",
  ]
end
