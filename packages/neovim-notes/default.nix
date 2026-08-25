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
          # Keep this profile independent from the full package defaults.
          ai.enable = lib.mkForce false;
          core.enable = lib.mkForce false;
          core.clipboard.enable = lib.mkForce false;
          core.herdr.enable = lib.mkForce false;
          core.mini.enable = lib.mkForce false;
          core.telescope.enable = lib.mkForce false;
          core.tmux.enable = lib.mkForce false;
          core.which-key.enable = lib.mkForce false;
          formatting.enable = lib.mkForce false;
          git.enable = lib.mkForce false;
          git.lazygit.enable = lib.mkForce true;
          lsp.enable = lib.mkForce false;
          search.enable = lib.mkForce false;
          productivity.enable = lib.mkForce false;
          productivity.auto-session.enable = lib.mkForce false;
          productivity.hop.enable = lib.mkForce false;
          productivity.inc-rename.enable = lib.mkForce false;
          productivity.navic.enable = lib.mkForce false;
          productivity.neo-tree.enable = lib.mkForce false;
          productivity.neoscroll.enable = lib.mkForce false;
          productivity.wrapping.enable = lib.mkForce false;
          productivity.yanky.enable = lib.mkForce false;
          ui.enable = lib.mkForce false;
          ui.barbar.enable = lib.mkForce false;
          ui.bufferline.enable = lib.mkForce false;
          ui.colorizer.enable = lib.mkForce false;
          ui.dashboard.enable = lib.mkForce false;
          ui.dressing.enable = lib.mkForce false;
          ui.goyo.enable = lib.mkForce false;
          ui.noice.enable = lib.mkForce false;
          ui.rainbow-delimiters.enable = lib.mkForce false;
          ui.web-devicons.enable = lib.mkForce false;

          utilities.direnv.enable = lib.mkForce false;
          utilities.floaterm.enable = lib.mkForce false;
          utilities.image.enable = lib.mkForce false;
          utilities.markdown-preview.enable = lib.mkForce false;
          utilities.nix.enable = lib.mkForce false;
          utilities.quickmath.enable = lib.mkForce false;
          utilities.render-markdown.enable = lib.mkForce false;
          utilities.snacks.enable = lib.mkForce false;

          # Markdown editing essentials.
          core.treesitter.enable = lib.mkForce true;

          # Keep only a colorscheme from the UI category.
          ui.colorscheme.enable = lib.mkForce true;
          ui.colorscheme.default = "kanagawa";

          # Obsidian's search and quick-switch commands need a picker. mini.pick is
          # substantially smaller than enabling the full Telescope stack.
          productivity.obsidian = {
            enable = lib.mkForce true;
            autoLoad = true;
            picker = "mini.pick";
            workspaces = [
              {
                name = "notes";
                path = "~/notes";
              }
            ];
            templatesFolder = "Templates";
          };
          productivity.silverbullet.enable = lib.mkForce true;

          # Marksman is useful for Markdown without enabling the repository's full
          # LSP category.
        };

        # Direct plugin configs outside the repository feature modules.
        plugins.lsp.enable = lib.mkForce true;
        plugins.lsp.servers.marksman.enable = lib.mkForce true;
        plugins.cmp.enable = lib.mkForce true;
        plugins.mini-pick.enable = true;
        plugins.obsidian.settings.legacy_commands = false;

        # Comprehensive obsidian.nvim keymaps organized by functionality
        keymaps = [
          # === Main operations (leader+o prefix) ===
          {
            key = "<leader>oo";
            action = "<cmd>Obsidian open<cr>";
            options = {
              desc = "Obsidian: Open in app";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>oq";
            action = "<cmd>Obsidian quick_switch<cr>";
            options = {
              desc = "Obsidian: Quick switch";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>os";
            action = "<cmd>Obsidian search<cr>";
            options = {
              desc = "Obsidian: Search vault";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>ob";
            action = "<cmd>Obsidian backlinks<cr>";
            options = {
              desc = "Obsidian: Backlinks";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>ol";
            action = "<cmd>Obsidian links<cr>";
            options = {
              desc = "Obsidian: Links in buffer";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>ot";
            action = "<cmd>Obsidian toc<cr>";
            options = {
              desc = "Obsidian: Table of contents";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>ow";
            action = "<cmd>Obsidian workspace<cr>";
            options = {
              desc = "Obsidian: Switch workspace";
              noremap = true;
              silent = true;
            };
          }

          # === New note operations (leader+on prefix) ===
          {
            key = "<leader>onn";
            action = "<cmd>Obsidian new<cr>";
            options = {
              desc = "Obsidian: New note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>ont";
            action = "<cmd>Obsidian new_from_template<cr>";
            options = {
              desc = "Obsidian: New from template";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>one";
            action = "<cmd>Obsidian extract_note<cr>";
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
            action = "<cmd>Obsidian today<cr>";
            options = {
              desc = "Obsidian: Today's note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>ody";
            action = "<cmd>Obsidian yesterday<cr>";
            options = {
              desc = "Obsidian: Yesterday's note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>odm";
            action = "<cmd>Obsidian tomorrow<cr>";
            options = {
              desc = "Obsidian: Tomorrow's note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>odd";
            action = "<cmd>Obsidian dailies<cr>";
            options = {
              desc = "Obsidian: Dailies list";
              noremap = true;
              silent = true;
            };
          }

          # === Insert/Link operations (leader+oi prefix) ===
          {
            key = "<leader>oil";
            action = "<cmd>Obsidian link<cr>";
            mode = "v";
            options = {
              desc = "Obsidian: Link selection";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>oin";
            action = "<cmd>Obsidian link_new<cr>";
            mode = "v";
            options = {
              desc = "Obsidian: Link to new note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>oip";
            action = "<cmd>Obsidian paste_img<cr>";
            options = {
              desc = "Obsidian: Paste image";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>oit";
            action = "<cmd>Obsidian template<cr>";
            options = {
              desc = "Obsidian: Insert template";
              noremap = true;
              silent = true;
            };
          }

          # === Refactoring operations (leader+or prefix) ===
          {
            key = "<leader>orr";
            action = "<cmd>Obsidian rename<cr>";
            options = {
              desc = "Obsidian: Rename note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>orc";
            action = "<cmd>Obsidian toggle_checkbox<cr>";
            options = {
              desc = "Obsidian: Toggle checkbox";
              noremap = true;
              silent = true;
            };
          }

          # === Alternative keymap ===
          # Quick access without prefix
          {
            key = "<leader><leader>";
            action = "<cmd>Obsidian quick_switch<cr>";
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
          {
            event = [ "FileType" ];
            pattern = [ "markdown" ];
            callback = {
              __raw = ''
                function(args)
                  vim.keymap.set("n", "gf", function()
                    if require("obsidian").util.cursor_on_markdown_link() then
                      return "<cmd>Obsidian follow_link<cr>"
                    end
                    return "gf"
                  end, { buffer = args.buf, expr = true, noremap = false, desc = "Obsidian: Follow link or gf" })
                  vim.keymap.set("n", "<CR>", function()
                    return require("obsidian").util.smart_action()
                  end, { buffer = args.buf, expr = true, desc = "Obsidian: Smart action" })
                end
              '';
            };
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
    if [ "$#" -eq 0 ]; then
      exec ${neovimNotes}/bin/nvim "$NOTES_DIR"
    else
      exec ${neovimNotes}/bin/nvim "$@"
    fi
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
