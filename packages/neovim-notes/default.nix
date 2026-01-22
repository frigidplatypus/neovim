{
  lib,
  pkgs,
  inputs,
  stdenv,
  ...
}:

let
  neovimNotes = (
    import ../neovim {
      inherit lib pkgs inputs;
      neovim-config = {
        frgdNeovim = {
          # === Category-level toggles ===
          ai.enable = lib.mkForce false;
          formatting.enable = lib.mkForce false;
          git.enable = lib.mkForce false;
          lsp.enable = lib.mkForce false;
          search.enable = lib.mkForce false;

          # === Core plugins (selective disabling) ===
          # Disable telescope for this standalone notes profile to avoid global keymaps
          core.telescope.enable = lib.mkForce false;

          # === UI plugins ===
          # Disable dashboard since notes launches directly into the notes directory
          ui.dashboard.enable = lib.mkForce false;
          # Use dressing for better UI selections
          ui.dressing.enable = lib.mkForce true;
          # Use kanagawa colorscheme for this notes profile
          ui.colorscheme.default = "kanagawa";

          # === Productivity plugins ===
          # Enable obsidian plugin for local notes vault with configured workspace
          productivity.obsidian = {
            enable = lib.mkForce true;
            workspaces = [
              {
                name = "notes";
                path = "~/notes";
              }
            ];
            templatesFolder = "Templates";
          };

          # === Utilities ===
          # Disable snacks to prevent <leader><leader> keymap conflict with obsidian
          utilities.snacks.enable = lib.mkForce false;

          # === LSP (selective enabling for markdown) ===
          lsp.otter.enable = lib.mkForce true;
        };

        # === Direct plugin configs (outside frgdNeovim) ===
        plugins.lsp.enable = lib.mkForce true;
        plugins.lsp.servers.marksman.enable = lib.mkForce true;

        # === Completion ===
        # Ensure completion framework is available for obsidian and cmp-related plugins
        plugins.cmp.enable = lib.mkForce true;

        # === Extra plugins (no nixvim module available) ===
        # Use legendary as a different command palette for notes
        extraPlugins = with pkgs.vimPlugins; [ legendary-nvim ];

        # === Keymaps ===
        # Comprehensive obsidian.nvim keymaps organized by functionality
        keymaps = [
          # === Main operations (leader+o prefix) ===
          {
            key = "<leader>oo";
            action = "<cmd>ObsidianOpen<cr>";
            options = {
              desc = "Obsidian: Open in app";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>oq";
            action = "<cmd>ObsidianQuickSwitch<cr>";
            options = {
              desc = "Obsidian: Quick switch";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>os";
            action = "<cmd>ObsidianSearch<cr>";
            options = {
              desc = "Obsidian: Search vault";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>ob";
            action = "<cmd>ObsidianBacklinks<cr>";
            options = {
              desc = "Obsidian: Backlinks";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>ol";
            action = "<cmd>ObsidianLinks<cr>";
            options = {
              desc = "Obsidian: Links in buffer";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>ot";
            action = "<cmd>ObsidianTOC<cr>";
            options = {
              desc = "Obsidian: Table of contents";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>ow";
            action = "<cmd>ObsidianWorkspace<cr>";
            options = {
              desc = "Obsidian: Switch workspace";
              noremap = true;
              silent = true;
            };
          }

          # === New note operations (leader+on prefix) ===
          {
            key = "<leader>onn";
            action = "<cmd>ObsidianNew<cr>";
            options = {
              desc = "Obsidian: New note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>ont";
            action = "<cmd>ObsidianNewFromTemplate<cr>";
            options = {
              desc = "Obsidian: New from template";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>one";
            action = "<cmd>ObsidianExtractNote<cr>";
            mode = "v";
            options = {
              desc = "Obsidian: Extract note";
              noremap = true;
              silent = true;
            };
          }

          # === Daily notes (leader+od prefix) ===
          {
            key = "<leader>odt";
            action = "<cmd>ObsidianToday<cr>";
            options = {
              desc = "Obsidian: Today's note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>ody";
            action = "<cmd>ObsidianYesterday<cr>";
            options = {
              desc = "Obsidian: Yesterday's note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>odm";
            action = "<cmd>ObsidianTomorrow<cr>";
            options = {
              desc = "Obsidian: Tomorrow's note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>odd";
            action = "<cmd>ObsidianDailies<cr>";
            options = {
              desc = "Obsidian: Dailies list";
              noremap = true;
              silent = true;
            };
          }

          # === Insert/Link operations (leader+oi prefix) ===
          {
            key = "<leader>oil";
            action = "<cmd>ObsidianLink<cr>";
            mode = "v";
            options = {
              desc = "Obsidian: Link selection";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>oin";
            action = "<cmd>ObsidianLinkNew<cr>";
            mode = "v";
            options = {
              desc = "Obsidian: Link to new note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>oip";
            action = "<cmd>ObsidianPasteImg<cr>";
            options = {
              desc = "Obsidian: Paste image";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>oit";
            action = "<cmd>ObsidianTemplate<cr>";
            options = {
              desc = "Obsidian: Insert template";
              noremap = true;
              silent = true;
            };
          }

          # === Refactoring operations (leader+or prefix) ===
          {
            key = "<leader>orr";
            action = "<cmd>ObsidianRename<cr>";
            options = {
              desc = "Obsidian: Rename note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>orc";
            action = "<cmd>ObsidianToggleCheckbox<cr>";
            options = {
              desc = "Obsidian: Toggle checkbox";
              noremap = true;
              silent = true;
            };
          }

          # === Navigation overrides ===
          {
            key = "gf";
            action = ''
              function()
                if require("obsidian").util.cursor_on_markdown_link() then
                  return "<cmd>ObsidianFollowLink<cr>"
                else
                  return "gf"
                end
              end
            '';
            options = {
              desc = "Obsidian: Follow link or gf";
              noremap = false;
              expr = true;
            };
          }
          {
            key = "<cr>";
            action = ''
              function()
                return require("obsidian").util.smart_action()
              end
            '';
            options = {
              desc = "Obsidian: Smart action";
              expr = true;
            };
          }

          # === Legacy/alternative keymaps ===
          # Quick access without prefix
          {
            key = "<leader><leader>";
            action = "<cmd>ObsidianQuickSwitch<cr>";
            options = {
              desc = "Obsidian: Quick switch";
              noremap = true;
              silent = true;
            };
          }
        ];

        # === Autocmds ===
        # Enable spell checking for markdown files
        autoCmd = [
          {
            event = [
              "BufRead"
              "BufNewFile"
            ];
            pattern = [ "*.md" ];
            command = "setlocal spell";
          }
        ];
      };
    }
  );
  notesScript = pkgs.writeShellScriptBin "notes" ''
    #!/bin/sh
    set -euo pipefail
    NOTES_DIR="$HOME/notes"
    cd "$NOTES_DIR" || { echo "notes: failed to cd to $NOTES_DIR" >&2; exit 1; }
    exec ${neovimNotes}/bin/nvim ${"\${@:-$NOTES_DIR}"}
  '';
in
stdenv.mkDerivation {
  pname = "neovim-notes";
  version = "0.1.0";
  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 ${notesScript}/bin/notes $out/bin/notes
    runHook postInstall
  '';
  meta = (neovimNotes.meta or { }) // {
    description = "Neovim (notes profile; core, ui, and markdown plugins enabled) with notes launcher";
    mainProgram = "notes";
  };
}
