{ config, lib, ... }:
with lib;
let
  cfg = config.frgdNeovim.ai.opencode;
in
{
  options.frgdNeovim.ai.opencode = with types; {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether or not to enable the opencode plugin.";
    };
  };
  config = mkIf cfg.enable {
    plugins.opencode.enable = true;

    # Required for auto_reload to detect file changes made by opencode
    opts.autoread = true;

    # Override terminal split position.
    # vim.g cannot hold Lua functions, so we modify opts directly as the plugin docs recommend.
    extraConfigLua = ''
      require("opencode.config").opts.server = {
        start = function()
          require("opencode.terminal").open("opencode --port", {
            split = "below",
            height = math.floor(vim.o.lines * 0.35),
          })
        end,
        stop = function()
          require("opencode.terminal").close()
        end,
        toggle = function()
          require("opencode.terminal").toggle("opencode --port", {
            split = "below",
            height = math.floor(vim.o.lines * 0.35),
          })
        end,
      }
    '';

    # snacks.input gives a proper input buffer for prompts (completions, highlights, normal-mode)
    # snacks is also required for the embedded terminal that hosts the opencode TUI
    plugins.snacks.settings.input.enabled = true;

    # snacks picker: <a-a> sends selected item to opencode while browsing
    plugins.snacks.settings.picker = {
      actions.opencode_send.__raw = ''
        function(...) return require("opencode").snacks_picker_send(...) end
      '';
      win.input.keys."<a-a>" = {
        __unkeyed-1 = "opencode_send";
        mode = [
          "n"
          "i"
        ];
      };
    };

    keymaps = [
      # --- Prompt / context ---
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>oa";
        action.__raw = ''function() require("opencode").ask("@this: ", { submit = true }) end'';
        options = {
          desc = "Opencode: Ask about selection / cursor";
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "<leader>ox";
        action.__raw = ''function() require("opencode").select() end'';
        options = {
          desc = "Opencode: Select action / prompt";
        };
      }
      {
        mode = [
          "n"
          "t"
        ];
        key = "<leader>ot";
        action.__raw = ''function() require("opencode").toggle() end'';
        options = {
          desc = "Opencode: Toggle terminal";
        };
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "go";
        action.__raw = ''function() return require("opencode").operator("@this ") end'';
        options = {
          desc = "Opencode: Send range/motion to opencode";
          expr = true;
        };
      }
      {
        mode = "n";
        key = "goo";
        action.__raw = ''function() return require("opencode").operator("@this ") .. "_" end'';
        options = {
          desc = "Opencode: Send current line to opencode";
          expr = true;
        };
      }
      # --- Session management ---
      {
        mode = "n";
        key = "<leader>on";
        action.__raw = ''function() require("opencode").command("session.new") end'';
        options = {
          desc = "Opencode: New session";
        };
      }
      {
        mode = "n";
        key = "<leader>os";
        action.__raw = ''function() require("opencode").command("session.select") end'';
        options = {
          desc = "Opencode: Select session";
        };
      }
      {
        mode = "n";
        key = "<leader>oi";
        action.__raw = ''function() require("opencode").command("session.interrupt") end'';
        options = {
          desc = "Opencode: Interrupt session";
        };
      }
      {
        mode = "n";
        key = "<leader>ok";
        action.__raw = ''function() require("opencode").command("session.compact") end'';
        options = {
          desc = "Opencode: Compact session (reduce context)";
        };
      }
      {
        mode = "n";
        key = "<leader>ou";
        action.__raw = ''function() require("opencode").command("session.undo") end'';
        options = {
          desc = "Opencode: Undo last session action";
        };
      }
      {
        mode = "n";
        key = "<leader>or";
        action.__raw = ''function() require("opencode").command("session.redo") end'';
        options = {
          desc = "Opencode: Redo last session action";
        };
      }
      # --- Scroll session from normal mode (outside embedded terminal) ---
      {
        mode = "n";
        key = "<S-C-u>";
        action.__raw = ''function() require("opencode").command("session.half.page.up") end'';
        options = {
          desc = "Opencode: Scroll session up";
        };
      }
      {
        mode = "n";
        key = "<S-C-d>";
        action.__raw = ''function() require("opencode").command("session.half.page.down") end'';
        options = {
          desc = "Opencode: Scroll session down";
        };
      }
    ];
  };
}
