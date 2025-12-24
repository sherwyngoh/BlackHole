#!/usr/bin/env bash
set -euo pipefail

# Build only the 2-channel BlackHole driver for Clarify bundling
# This is a simplified version that skips notarization

driverName="BlackHole"
devTeamID="544929U6B4"
channels=2
ch="${channels}ch"
driverVartiantName=$driverName$ch
bundleID="audio.existential.$driverVartiantName"

echo "Building $driverVartiantName for bundling with Clarify..."

# Build
xcodebuild \
  -project BlackHole.xcodeproj \
  -configuration Release \
  -target BlackHole CONFIGURATION_BUILD_DIR=build \
  PRODUCT_BUNDLE_IDENTIFIER=$bundleID \
  MACOSX_DEPLOYMENT_TARGET=10.13 \
  CODE_SIGN_STYLE=Manual \
  CODE_SIGN_IDENTITY="Developer ID Application" \
  DEVELOPMENT_TEAM=$devTeamID \
  GCC_PREPROCESSOR_DEFINITIONS="\$(GCC_PREPROCESSOR_DEFINITIONS) kNumber_Of_Channels=$channels kPlugIn_BundleID=\\\"$bundleID\\\" kDriver_Name=\\\"$driverName\\\""

echo "✓ Build complete!"

# Show the driver path
echo ""
echo "Driver built at: $(pwd)/build/BlackHole.driver"
