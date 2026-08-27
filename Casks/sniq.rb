cask "sniq" do
  version "1.5.0"
  sha256 "7e197bb47770ec7859bf3027e18238828b459bd9cd06c3a3286566c7d972f9ef"

  url "https://github.com/oh-research/Sniq/releases/download/v#{version}/sniq-#{version}.dmg"
  name "Sniq"
  desc "Snap windows to a custom grid with modifier-key drag"
  homepage "https://github.com/oh-research/Sniq"

  depends_on macos: :sequoia

  app "Sniq.app"

  postflight do
    system_command "/usr/bin/open",
                   args: ["#{appdir}/Sniq.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.ohresearch.sniq.plist",
    "~/Library/Application Support/Sniq",
  ]
end
