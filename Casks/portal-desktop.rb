# Homebrew cask — Portal Desktop (the macOS menu-bar app, notarized).
#
# The shipped product. Built by `cargo tauri build` (signed + notarized), the .dmg
# hosted as a GitHub Release on emrul/portal-desktop. publish-app-cask.sh fills in
# the version + sha256 and renders this into the tap (emrul/homebrew-portal).
#
# Install: brew install --cask emrul/portal/portal-desktop
cask "portal-desktop" do
  # Auto-bumped to 0.1.<git-commit-count> by publish-app-cask.sh so `brew upgrade`
  # picks up every republish (the app's internal version stays 0.1.0).
  version "0.1.163"
  sha256 "0e73043a87418dccf079c127cc1f64a9c01fd82c18f4314c9509d17b5e58be8b"

  url "https://github.com/emrul/portal-desktop/releases/download/app-v#{version}/Portal-Desktop-#{version}-arm64.dmg"
  name "Portal Desktop"
  desc "Stream a desktop you own to a browser — capture, H.264, WebTransport/WebRTC"
  homepage "https://github.com/emrul/portal-desktop"

  # No ffmpeg: the macOS app encodes via direct VideoToolbox and links no ffmpeg.
  depends_on arch:    :arm64
  depends_on macos:   :sonoma

  app "Portal Desktop.app"

  caveats <<~EOS
    Portal Desktop lives in the menu bar. On first launch it guides you through
    Screen Recording (and, for keyboard/mouse control, Accessibility) in System
    Settings. Use the menu-bar icon to start/stop serving, open the viewer, copy the
    link, or change settings.
  EOS
end
