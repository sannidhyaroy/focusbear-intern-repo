# Notarization

## What is Notarization?

Notarization is Apple's automated security scan for macOS apps distributed outside the Mac App Store. Before distributing a signed app, the developer submits it to Apple's notarization service, which scans the binary for known malware, validates the signing certificate, and checks that the hardened runtime is enabled. If the scan passes, Apple issues a notarization ticket that is stapled to the app. When a user opens the app, Gatekeeper verifies the ticket online or locally from the stapled copy.

Notarization does not mean Apple reviewed or approved the app, it means the binary passed an automated scan at the time of submission. It is a trust signal, not a quality guarantee.

## Requirements

Notarization requires:

- A paid Apple Developer Program membership ($99/year)
- A Developer ID Application certificate
- Hardened runtime enabled for all targets
- No invalid entitlements or private API usage that the scanner flags

## Tools

### `notarytool`

`notarytool` is the current command-line tool for submitting apps to Apple's notarization service. It replaced `altool` in Xcode 13 and is the only supported submission method as of macOS Ventura.

```bash
# Submit a dmg for notarization
xcrun notarytool submit App.dmg \
    --apple-id "tsterling@nautilus.edu.sap" \
    --team-id "XXXXXXXXXX" \
    --password "app-specific-password" \
    --wait

# Check submission status
xcrun notarytool log <submission-id> \
    --apple-id "tsterling@nautilus.edu.sap" \
    --team-id "XXXXXXXXXX" \
    --password "app-specific-password"
```

The `--wait` flag blocks until notarization completes rather than returning a submission ID to poll later. Notarization typically takes under a minute for small apps but can take longer under load.

### stapler

After notarization succeeds, the ticket must be stapled to the app or dmg so users can verify it offline without a network connection.

```bash
xcrun stapler staple App.dmg
```

Stapling attaches the notarization ticket directly to the file. Without stapling, Gatekeeper still verifies the ticket but requires an internet connection at launch. Stapling is especially important for dmg distribution where users may install offline.

### Xcode Organizer

The Xcode Organizer (`Window > Organizer > Archives`) provides a graphical user interface for notarization. After archiving an app, the `Distribute App` button walks through signing, notarization, and stapling in a single flow. The Organizer also shows notarization history and logs for past submissions.

### `altool` (deprecated)

`altool` was the previous notarization tool, deprecated in Xcode 13 and removed in Xcode 14. Any documentation or CI scripts referencing `altool` for notarization should be updated to use `notarytool`.

## Notarization in CI/CD

For automated release pipelines, credentials should never be hardcoded. Use app-specific passwords stored in the keychain or CI secrets:

```bash
# Store credentials in keychain (one-time setup)
xcrun notarytool store-credentials "notarytool-profile" \
    --apple-id "tsterling@nautilus.edu.sap" \
    --team-id "XXXXXXXXXX" \
    --password "app-specific-password"

# Use stored credentials in CI
xcrun notarytool submit App.dmg \
    --keychain-profile "notarytool-profile" \
    --wait
```

GitHub Actions can store the app-specific password as a secret and pass it via environment variable rather than a keychain profile when running on ephemeral CI runners.

## Practical Note

If a paid Developer ID certificate were available, the notarization workflow for a macOS app usually would be:

1. Archive the build in Xcode
2. Submit the dmg via `notarytool`
3. Staple the ticket via `stapler`
4. Attach the stapled dmg to the GitHub Release
