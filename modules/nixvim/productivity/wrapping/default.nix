{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity.wrapping;
in
{
  options.frgdNeovim.productivity.wrapping.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable wrapping productivity plugin.";
  };

  config = mkIf cfg.enable {
    plugins.wrapping = {
      enable = true;
      settings = {
        auto_set_mode_filetype_allowlist = [
          "asciidoc"
          "gitcommit"
          "help"
          "latex"
          "mail"
          "markdown"
          "rst"
          "tex"
          "text"
          "typst"
        ];
      };
    };
  };
}
