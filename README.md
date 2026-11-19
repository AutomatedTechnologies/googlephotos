# Photos — Academy Build

A Detroit Automation Academy application: a native macOS window for
Google Photos, built for distribution through Distro on macOS 10.13
(High Sierra) and later.

## Provenance

Academy-original, clean-room code. This application was written by the
Detroit Automation Academy from scratch. It contains no Google code, no
Google assets, and no code or assets from any other upstream project —
there is no upstream. It loads the public Google Photos web service
(photos.google.com) in a standard system web view; "Google Photos" is
named only to say what the application is a client for.

## What it is

- `AppDelegate` — application entry, main window, menus.
- `PhotosWebViewController` — hosts a `WKWebView` on photos.google.com
  with a desktop Safari user agent and the persistent default
  `WKWebsiteDataStore`, so the Google session survives relaunches.
  Google hosts stay in the web view; other hosts open in the default
  browser.
- `Photos/Resources/AppIcon.iconset` — the monochrome Academy icon (ink photo pictogram on the white tile), built to `Photos.icns` by CI.
- `WelcomeWindowController` — the SDS-8 welcome window: shown on first
  launch, dismissible, re-openable from the Help menu.

Bundle ID: `com.detroitautomationacademy.googlephotos`
Floor: macOS 10.13.
