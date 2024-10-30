{
  plugins.conform-nvim = {
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
      # format_on_save = # Lua
      #   ''
      #     function(bufnr)
      #       if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      #         return
      #       end
      #
      #       if slow_format_filetypes[vim.bo[bufnr].filetype] then
      #         return
      #       end
      #
      #       local function on_format(err)
      #         if err and err:match("timeout$") then
      #           slow_format_filetypes[vim.bo[bufnr].filetype] = true
      #         end
      #       end
      #
      #       return { timeout_ms = 200, lsp_fallback = true }, on_format
      #      end
      #   '';
      format_after_save = # Lua
        ''
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
      options = {
        desc = "[F]ormat buffer";
      };
    }
  ];
}
