{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.productivity.surround;
in
{
  options.frgdNeovim.productivity.surround.enable = mkOption {
    type = types.bool;
    default = false; # Disabled - replaced by mini.surround
    description = "Enable surround productivity plugin. Replaced by mini.surround.";
  };

  config = mkIf cfg.enable {
    plugins.vim-surround.enable = false;
    plugins."nvim-surround".enable = true;
    plugins."nvim-surround".settings = {
      keymaps = {
        insert = "<C-g>s";
        insert_line = "<C-g>S";
        normal = "ys";
        normal_cur = "yss";
        normal_line = "yS";
        normal_cur_line = "ySS";
        visual = "S";
        visual_line = "gS";
        delete = "ds";
        change = "cs";
        change_line = "cS";
      };
    };
  };
}
