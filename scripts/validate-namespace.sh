#!/usr/bin/env fish
# Search for non-canonical namespace usages and report them
set -l repo_root (pwd)
echo "Validating namespace usage in repository..."
set -l bad
for p in (rg --hidden --no-ignore -n "frgd\.apps\.|frgd\.nixvim\." --glob '!./.git' --line-number --no-heading || true)
    echo $p
    set bad 1
end
if test -n "$bad"
    echo "Found legacy namespace patterns (frgd.apps or frgd.nixvim). Please standardize to 'frgdNeovim.nixvim'."
    exit 1
end
echo "No namespace inconsistencies found."
exit 0
