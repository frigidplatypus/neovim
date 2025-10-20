{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.lsp.lsp-format;
in
{
  options.frgdNeovim.lsp.lsp-format.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable lsp-format LSP plugin.";
  };

  config = mkIf cfg.enable {
    plugins."lsp-format".enable = true;
  };
}
