cask "sniq" do
  version "1.2.0"
  sha256 "20842ea705b044be89c5f0de45b565c08f43e49ed26185c33aee23200ee96ea5"

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
