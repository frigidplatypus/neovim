#!/usr/bin/env fish
echo "Testing autopairs enable/disable toggle..."
set enabled (nix eval --impure --expr '(import ./tests/eval/autopairs-eval.nix { enable = true; }).autopairsPresent' | tr -d '\n')
set disabled (nix eval --impure --expr '(import ./tests/eval/autopairs-eval.nix { enable = false; }).autopairsPresent' | tr -d '\n')
echo "Enabled case autopairsPresent=$enabled"
echo "Disabled case autopairsPresent=$disabled"
if test "$enabled" != "true"
  echo "FAIL: Expected autopairsPresent=true when enable=true"; exit 1
end
if test "$disabled" != "false"
  echo "FAIL: Expected autopairsPresent=false when enable=false"; exit 1
end
echo "Autopairs toggle test passed."
exit 0
