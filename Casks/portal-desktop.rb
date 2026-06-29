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
  version "0.1.326"
  sha256 "e2426e25d82e7cc298c2053425c296930cbfc7b8d93887efe38d4a6b92bb74a6"

  url "https://github.com/emrul/portal-desktop/releases/download/app-v#{version}/Portal-Desktop-#{version}-arm64.dmg"
  name "Portal Desktop"
  desc "Stream a desktop you own to a browser — capture, H.264, WebTransport/WebRTC"
  homepage "https://github.com/emrul/portal-desktop"

  # No ffmpeg: the macOS app encodes via direct VideoToolbox and links no ffmpeg.
  depends_on arch:    :arm64
  depends_on macos:   :sonoma

  app "Portal Desktop.app"

  # Strip the quarantine xattr Homebrew stamps on cask apps. The app is notarized +
  # Developer-ID signed, so this only removes the one-time "downloaded from the
  # Internet — are you sure?" CONSENT dialog (Gatekeeper's signature/notarization
  # checks still run). That dialog is a single click for a desktop user, but it
  # BLOCKS a host launched over SSH / unattended — the process waits forever on a
  # click that never comes. Essential for headless/remote hosts. (must_succeed:
  # false so a --no-quarantine install, where the attr is already absent, is fine.)
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-d", "-r", "com.apple.quarantine", "#{appdir}/Portal Desktop.app"],
                   must_succeed: false
  end

  caveats <<~EOS
    Portal Desktop lives in the menu bar. On first launch it guides you through
    Screen Recording (and, for keyboard/mouse control, Accessibility) in System
    Settings. Use the menu-bar icon to start/stop serving, open the viewer, copy the
    link, or change settings.

    Headless / remote host: Portal Desktop is a GUI menu-bar app, not a daemon — it
    needs an active login (Aqua) session to capture the screen, so a truly unattended
    Mac needs Auto-Login enabled (System Settings > Users & Groups) plus the app's
    "Start at login" toggle. Screen Recording (and Accessibility for input control)
    must be granted once interactively in System Settings — they can't be enabled
    headlessly without an MDM PPPC profile. After that the stable Developer-ID
    identity keeps the grants across upgrades.
  EOS
end
