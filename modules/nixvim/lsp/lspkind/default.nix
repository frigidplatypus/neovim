{ lib, ... }:
let wrap = lib.moduleEnable;
in wrap "lspkind" {
  plugins.lspkind = {
    enable = true;

    symbolMap = {
      Copilot = "";
    };

    extraOptions = {
      maxwidth = 50;
      ellipsis_char = "...";
    };
  };
}
