cask "juggler" do
  version "1.6.0"
  sha256 "ade622d3664f2443ffa757bc3f9b3bd3e43bb9147e2e3cb3fe531e47b6344a2f"

  url "https://github.com/nielsmadan/juggler/releases/download/v#{version}/Juggler.dmg"
  name "Juggler"
  desc "Global hotkey navigation for Claude Code sessions"
  homepage "https://github.com/nielsmadan/juggler"

  depends_on macos: ">= :sonoma"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Juggler.app"

  zap trash: [
    "~/Library/Application Support/Juggler",
    "~/Library/Preferences/com.nielsmadan.Juggler.plist",
    "~/Library/Caches/com.nielsmadan.Juggler",
  ]
end
