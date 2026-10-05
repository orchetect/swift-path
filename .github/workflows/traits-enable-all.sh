#!/bin/sh
#
# Edits the package manifest to enable all package traits by default.
# There is no swift command to edit package traits, so manually editing the package manifest is the best interim solution.

REPO_PATH="$(git rev-parse --show-toplevel)"

echo "Repo Path: $REPO_PATH"
cd "$REPO_PATH"

echo "Enabling all package traits in package manifest."
perl -pi -e 's/\.default\(enabledTraits\: \[\]\)/\.default\(enabledTraits\: \[\"osc\"\]\)/g' Package.swift