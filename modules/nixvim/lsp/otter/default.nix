{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.lsp.otter;
in
{
  options.frgdNeovim.lsp.otter.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable otter LSP plugin.";
  };

  config = mkIf cfg.enable {
    plugins.otter.enable = true;
  };
}
