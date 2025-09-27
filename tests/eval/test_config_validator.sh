#!/usr/bin/env bash
# Test feedback validator for user-friendly error messages
set -euo pipefail

echo "Testing config validator feedback..."

ROOT_DIR="$(pwd)"
TMP_PROFILE="$ROOT_DIR/tmp-test-profile.nix"

# Test 1: Valid profile should pass
cat > "$TMP_PROFILE" <<'NIX'
[ "autopairs" "clipboard" "treesitter" ]
NIX

echo "Testing valid profile..."
if ! ./scripts/validate-config.sh "$TMP_PROFILE" >/dev/null; then
  echo "ERROR: Valid profile failed validation"
  rm -f "$TMP_PROFILE"
  exit 1
fi

# Test 2: Invalid module should fail with helpful message
cat > "$TMP_PROFILE" <<'NIX'
[ "autopairs" "nonexistent-module" "treesitter" ]
NIX

echo "Testing invalid module detection..."
set +e
OUTPUT=$(./scripts/validate-config.sh "$TMP_PROFILE" 2>&1)
RC=$?
set -e

if [ $RC -eq 0 ]; then
  echo "ERROR: Invalid profile passed validation when it should fail"
  rm -f "$TMP_PROFILE"
  exit 1
fi

if ! echo "$OUTPUT" | grep -q "Unknown modules"; then
  echo "ERROR: Validator did not provide helpful 'Unknown modules' message"
  echo "Got output: $OUTPUT"
  rm -f "$TMP_PROFILE"
  exit 1
fi

if ! echo "$OUTPUT" | grep -q "nonexistent-module"; then
  echo "ERROR: Validator did not identify the specific unknown module"
  echo "Got output: $OUTPUT"
  rm -f "$TMP_PROFILE"
  exit 1
fi

rm -f "$TMP_PROFILE"
echo "Config validator feedback tests passed."
exit 0