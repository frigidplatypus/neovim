{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.lsp;
in
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
    frgdNeovim.lsp.cmp.enable = lib.mkDefault true;
    frgdNeovim.lsp.lsp-config.enable = lib.mkDefault true;
    frgdNeovim.lsp.lsp-format.enable = lib.mkDefault true;
    frgdNeovim.lsp.lspkind.enable = lib.mkDefault true;
    frgdNeovim.lsp.none-ls.enable = lib.mkDefault true;
    frgdNeovim.lsp.otter.enable = lib.mkDefault true;
    frgdNeovim.lsp.trouble.enable = lib.mkDefault true;
  };
}
