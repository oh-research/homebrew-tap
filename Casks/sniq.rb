cask "sniq" do
  version "1.3.0"
  sha256 "794cd853402e27a1c8b9d44d5be1bd157b13575e20a24ad51737c4a40aaab53e"

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
