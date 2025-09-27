#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(pwd)"
CORE_FILE="$ROOT_DIR/specs/002-modules-should-have/core-modules.nix"
if [ ! -f "$CORE_FILE" ]; then
  echo "core-modules.nix missing" >&2
  exit 2
fi

echo "Checking core modules exist..."

if command -v rg >/dev/null 2>&1; then
  MODULES=$(rg -o '"[^"]+"' "$CORE_FILE" | tr -d '"' | tr '\n' ' ')
else
  MODULES=$(grep -o '"[^"]\+"' "$CORE_FILE" | tr -d '"' | tr '\n' ' ')
fi
missing=()
for m in $MODULES; do
  # search for module directory
  if ! ls modules/nixvim/*/$m/default.nix >/dev/null 2>&1; then
    missing+=("$m")
  fi
done

if [ ${#missing[@]} -ne 0 ]; then
  echo "Missing core modules: ${missing[*]}"
  exit 3
fi

echo "All core modules present: $MODULES"
exit 0
#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(pwd)"
CORE_FILE="$ROOT_DIR/specs/002-modules-should-have/core-modules.nix"
if [ ! -f "$CORE_FILE" ]; then
  echo "Missing core-modules.nix"; exit 2
fi

# naive parse for names
CORE_NAMES=$(sed -n '2,20p' "$CORE_FILE" | tr -d '[]"' | tr -s '\n' ' ')
MISSING=()
for m in $CORE_NAMES; do
  if ! rg -n "\/$(echo $m)\/default.nix$" --hidden --no-ignore --glob '!./.git' > /dev/null 2>&1; then
    MISSING+=("$m")
  fi
done

if [ ${#MISSING[@]} -ne 0 ]; then
  echo "Missing module directories for: ${MISSING[*]}"; exit 1
fi
echo "All core modules exist."; exit 0
