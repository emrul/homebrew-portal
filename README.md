# Homebrew tap — Portal Desktop

A [Homebrew](https://brew.sh) tap for `portal-desktop` — stream a desktop you own to a
browser (capture → H.264 → WebTransport/WebRTC).

## Install (macOS, Apple Silicon)

```sh
brew install --cask emrul/portal/portal-desktop
```

The cask installs a notarized, Developer-ID-signed binary (artifacts hosted as GitHub
Releases on [`emrul/portal-desktop`](https://github.com/emrul/portal-desktop)). `ffmpeg`
is pulled automatically.

First run prompts for **Screen Recording** (capture) and, with `--enable-input`,
**Accessibility** in System Settings → Privacy & Security; because the binary is signed
with a stable identity, those grants persist across upgrades.

```sh
portal-desktop --capture --enable-input
```
