cask "juggler" do
  version "1.12.0"
  sha256 "6539b67cd905d1f0d7e9fcad49f3065be138b49e2a61e6eb51377fe954c91f9a"

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
