cask "juggler" do
  version "1.11.0"
  sha256 "910c9e003af6c439fb87f0d279215b42227447b52fc33d54144bf945268b978f"

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
