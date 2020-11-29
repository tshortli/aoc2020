#!/bin/bash

# Checks if swiftlint has been installed, displaying an error in Xcode if it's missing.

if which swiftlint >/dev/null; then
  swiftlint --config ../swiftlint.yml
else
  echo "warning: SwiftLint not installed, download from https://stash.sd.apple.com/projects/DP/repos/swiftlint_distribution"
fi
