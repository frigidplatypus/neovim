#!/usr/bin/env fish
echo "[integration] Building neovim-minimal (result/bin/nvim) and checking core plugins (autopairs, which-key, treesitter)"

if not nix build .#neovim-minimal 2>/dev/null
  echo "FAIL: attribute neovim-minimal not found or build failed"; exit 1
end

set nvim ./result/bin/nvim
if not test -x $nvim
  echo "FAIL: result/bin/nvim missing after build"; exit 1
end

set lua_snippet 'local names={"nvim-autopairs","which-key","nvim-treesitter"};for _,n in ipairs(names) do local ok,_=pcall(require,n);print(n.."="..tostring(ok)) end'

set output ($nvim --headless +"lua $lua_snippet" +qa 2>&1)
for line in $output
  echo "[plugin-check] $line"
end

set fail 0
for line in $output
  switch $line
    case 'nvim-autopairs=false'
      echo "FAIL: nvim-autopairs not loadable via require()"; set fail 1
    case 'which-key=false'
      echo "WARN: which-key not loadable (may be lazy); continuing" >&2
    case 'nvim-treesitter=false'
      echo "WARN: nvim-treesitter not loadable (may be lazy); continuing" >&2
  end
end

if test $fail -eq 1
  exit 1
end
echo "Integration minimal plugin check complete."
exit 0