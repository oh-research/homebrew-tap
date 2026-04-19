cask "sniq" do
  version "1.3.0"
  sha256 "e705559ce2f1c623c1b2767f68ecaaa74c6854d35dd5d8d404abc9f31c670445"

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
