#!/usr/bin/env fish
echo "Running integration toggle test for autopairs (build variants)..."
set -l start (date +%s)

function build_and_get_path
  set -l attr $argv[1]
  set -l p (nix build .#$attr --print-out-paths --no-link 2>/dev/null | tail -n1)
  or begin
    echo "FAIL: build of $attr failed"; exit 1
  end
  echo $p
end

set with_path (build_and_get_path neovim)
set without_path (build_and_get_path neovim-autopairs-disabled)

function plugin_present
  set -l path $argv[1]
  # Look for plugin directory first (common nixvim layout)
  if find $path -maxdepth 15 -type d -iname 'nvim-autopairs' | grep -q 'nvim-autopairs'
    return 0
  end
  # Fallback: any lua file referencing core autopairs module name
  if grep -R --quiet 'nvim%-autopairs' $path/share/nvim 2>/dev/null
    return 0
  end
  return 1
end

echo "Verifying autopairs present in enabled build..."
if not plugin_present $with_path
  echo "FAIL: autopairs not detected in enabled build ($with_path)"; exit 1
end

echo "Verifying autopairs absent in disabled build..."
if plugin_present $without_path
  echo "FAIL: autopairs detected in disabled build ($without_path)"; exit 1
end

set -l end (date +%s)
echo "Autopairs integration toggle test passed in (math $end - $start) seconds." | sed 's/(math /(/'
exit 0
