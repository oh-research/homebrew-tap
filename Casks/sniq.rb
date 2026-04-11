cask "sniq" do
  version "1.1.0"
  sha256 "adafdfbe94ce02976c964986b434fcb190f97ea0733384cf6d90cd7990efe09e"

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
