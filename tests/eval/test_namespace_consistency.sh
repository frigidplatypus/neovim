#!/usr/bin/env fish
echo "Running namespace consistency test..."
set -l found (rg --hidden --no-ignore -n "frgd\.apps\.|frgd\.nixvim\." --glob '!./.git' --line-number --no-heading || true)
if test -n "$found"
    echo "Namespace inconsistencies detected:"; echo $found; exit 1
end
echo "Namespace consistency OK (no frgd.apps or frgd.nixvim occurrences). Use frgdNeovim.nixvim."
exit 0
