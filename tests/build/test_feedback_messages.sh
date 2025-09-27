#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(pwd)"
echo "Running feedback validator test..."
TMP_PROFILE="$ROOT_DIR/specs/002-modules-should-have/tmp-bad-profile.nix"
cat > "$TMP_PROFILE" <<'NIX'
[ "autopairs" "nonexistent-module" ]
NIX
set +e
OUT=$(./scripts/validate-config.sh "$TMP_PROFILE" 2>&1)
RC=$?
set -e
if [ $RC -eq 0 ]; then
  echo "Expected validator to fail for unknown module; it passed."; exit 1
fi
echo "Validator output:"
echo "$OUT"
if ! echo "$OUT" | grep -q "Unknown modules"; then
  echo "Validator did not print expected 'Unknown modules' message"; exit 1
fi
rm -f "$TMP_PROFILE"
echo "Feedback validator test passed."
exit 0
