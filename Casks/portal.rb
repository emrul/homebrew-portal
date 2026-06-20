# Homebrew cask — Portal Desktop (the macOS menu-bar app, notarized).
#
# This is the GUI product (correct TCC identity, onboarding, settings). The bare
# CLI ships separately as the `portal-desktop` cask + `emrul/portal-dev` formula
# for headless/remote use. Built by `cargo tauri build` (signed + notarized), the
# .dmg hosted as a GitHub Release on emrul/portal-desktop.
#
# Install: brew install --cask emrul/portal/portal
cask "portal" do
  # Auto-bumped to 0.1.<git-commit-count> by publish-app-cask.sh so `brew upgrade`
  # picks up every republish (the app's internal version stays 0.1.0).
  version "0.1.89"
  sha256 "0c4cf245bb1656ad50a41f089a56383442e73b621ac62c9da072b7c19dfafbfc"

  url "https://github.com/emrul/portal-desktop/releases/download/app-v#{version}/Portal-Desktop-#{version}-arm64.dmg"
  name "Portal Desktop"
  desc "Stream a desktop you own to a browser — capture, H.264, WebTransport/WebRTC"
  homepage "https://github.com/emrul/portal-desktop"

  depends_on formula: "ffmpeg"
  depends_on arch:    :arm64
  depends_on macos:   :sonoma

  app "Portal Desktop.app"

  caveats <<~EOS
    Portal Desktop lives in the menu bar. On first launch it guides you through
    Screen Recording (and, for keyboard/mouse control, Accessibility) in System
    Settings. Use the menu-bar icon to open the viewer, copy the link, or change
    settings. ffmpeg is installed as a dependency.
  EOS
end
