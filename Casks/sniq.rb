cask "sniq" do
  version "1.5.0"
  sha256 "aa264c7f7b9e141d15212bf4db120e24aa362e4a2016d7515ebbbea7d2f39a1f"

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
