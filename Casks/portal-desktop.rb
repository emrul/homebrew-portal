# Homebrew cask — portal-desktop (phase 2: notarized, prebuilt, for distribution).
#
# Canonical copy. scripts/macos/brew-publish-cask.sh fills in the sha256 and renders
# this into the published tap (emrul/homebrew-portal), and the url points at the
# notarized zip hosted as a GitHub Release on emrul/portal-desktop (artifacts-only).
#
# Install (anyone): brew install --cask emrul/portal/portal-desktop
cask "portal-desktop" do
  version "0.1.0"
  sha256 "92c19d761ba57be0c656faf36dc8bbe9e4f127eaf8a6948d678abbc851f69634"

  url "https://github.com/emrul/portal-desktop/releases/download/v#{version}/portal-desktop-#{version}-arm64.zip"
  name "Portal Desktop"
  desc "Stream a desktop you own to a browser — capture, H.264, WebTransport/WebRTC"
  homepage "https://github.com/emrul/portal-desktop"

  depends_on formula: "ffmpeg"
  depends_on arch:    :arm64
  depends_on macos:   :sonoma # Sonoma (14) or newer

  binary "portal-desktop"

  caveats <<~EOS
    First run prompts for macOS permissions (System Settings → Privacy & Security):
      • Screen Recording — required for capture
      • Accessibility    — required only with --enable-input (keyboard/mouse)

    Start it:
      portal-desktop --capture --enable-input
    then open the printed https URL in Chrome or Edge. On the same machine use
    https://127.0.0.1:8080 — "localhost" breaks WebTransport.
  EOS
end
