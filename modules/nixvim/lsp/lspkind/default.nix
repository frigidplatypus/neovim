{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "lspkind" {
  plugins.lspkind = {
    enable = true;

    settings.symbol_map = {
      Copilot = "";
    };

    settings = {
      maxwidth = 50;
      ellipsis_char = "...";
    };
  };
}
