cask "juggler" do
  version "1.9.0"
  sha256 "8d8095704b39c0f7696e34e796cfd2f7d0d535ad75931f0755ae1c4b2f9647d1"

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
