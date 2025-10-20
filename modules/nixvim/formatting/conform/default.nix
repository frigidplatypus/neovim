{ lib, config, ... }:
with lib;
let
  cfg = config.frgdNeovim.formatting.conform;
in
{
  options.frgdNeovim.formatting.conform.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable conform.nvim formatting plugin.";
  };

  config = mkIf cfg.enable {
    plugins."conform-nvim" = {
      enable = true;
      settings = {
        formatters_by_ft = {
          nix = [ "nixfmt" ];
          bash = [
            "shellcheck"
            "shellharden"
            "shfmt"
          ];
          cpp = [ "clang_format" ];
          javascript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            timeout_ms = 2000;
            stop_after_first = true;
          };
          "_" = [
            "squeeze_blanks"
            "trim_whitespace"
            "trim_newlines"
          ];
        };
        format_after_save = ''
          function()
            require('conform').format { async = true, lsp_fallback = true }
          end
        '';
        log_level = "warn";
        notify_on_error = true;
        notify_no_formatters = true;
      };
    };
    keymaps = [
      {
        mode = "";
        key = "<leader>r";
        action.__raw = ''
          function()
            require('conform').format { async = true, lsp_fallback = true }
          end
        '';
        options.desc = "[F]ormat buffer";
      }
    ];
  };
}
