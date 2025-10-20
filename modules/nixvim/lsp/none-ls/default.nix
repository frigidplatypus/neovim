{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.lsp.none-ls;
in
{
  options.frgdNeovim.lsp.none-ls.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable none-ls LSP plugin.";
  };

  config = mkIf cfg.enable {
    plugins."none-ls" = {
      enable = true;
      sources.diagnostics.deadnix.enable = true;
    };
  };
}
