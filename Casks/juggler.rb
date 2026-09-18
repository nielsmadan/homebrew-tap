cask "juggler" do
  version "1.9.1"
  sha256 "58909cb18e0c23baca09eec421a876eceb16665d282289cee73faeccb94170af"

  url "https://github.com/nielsmadan/juggler/releases/download/v#{version}/Juggler.dmg"
  name "Juggler"
  desc "Global hotkey navigation for coding agent sessions"
  homepage "https://jugglerapp.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sequoia

  app "Juggler.app"

  uninstall quit: "com.nielsmadan.Juggler"

  zap script: {
        executable: "#{staged_path}/Juggler.app/Contents/Resources/uninstall.sh",
      },
      trash:  [
        "~/Library/Application Support/Juggler",
        "~/Library/Caches/com.nielsmadan.Juggler",
        "~/Library/Preferences/com.nielsmadan.Juggler.plist",
      ]
end
