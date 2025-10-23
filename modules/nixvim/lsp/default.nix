{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.lsp;
in
{
  options.frgdNeovim.lsp.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable all LSP plugins.";
  };

  config = mkIf cfg.enable {
    frgdNeovim.lsp.cmp.enable = true;
    frgdNeovim.lsp.lsp-config.enable = true;
    frgdNeovim.lsp.lsp-format.enable = true;
    frgdNeovim.lsp.lspkind.enable = true;
    frgdNeovim.lsp.none-ls.enable = true;
    frgdNeovim.lsp.otter.enable = true;
    frgdNeovim.lsp.trouble.enable = true;
  };
}
