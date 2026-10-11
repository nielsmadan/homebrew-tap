cask "juggler" do
  version "1.10.0"
  sha256 "6e7a5d35023ba697163d16c5e69e198fa6cbc1d963aaddb667ce7f78a94438c8"

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
