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
        frgdNeovim.ai.enable = lib.mkForce false;
        frgdNeovim.formatting.enable = lib.mkForce false;
        frgdNeovim.git.enable = lib.mkForce false;
        frgdNeovim.lsp.enable = lib.mkForce false;
        frgdNeovim.search.enable = lib.mkForce false;
        # Disable telescope for this standalone notes profile to avoid global keymaps
        frgdNeovim.core.telescope.enable = lib.mkForce false;
        # Disable snacks to prevent <leader><leader> keymap conflict with obsidian
        frgdNeovim.utilities.snacks.enable = lib.mkForce false;
        # Enable obsidian plugin directly for local notes vault
        plugins.obsidian.enable = lib.mkForce true;
        plugins.obsidian.settings = {
          # Provide at least one workspace as a list (obsidian.nvim expects an array)
          workspaces = [
            {
              name = "notes";
              path = "/home/justin/notes";
            }
          ];
          templates = {
            folder = "/home/justin/notes/Templates";
          };
        };

        # Set obsidian keymaps using nixvim's keymaps system
        keymaps = [
          {
            key = "<leader><leader>";
            action = "<cmd>ObsidianSearch<cr>";
            options = {
              desc = "Notes: Search vault";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>nn";
            action = "<cmd>ObsidianNew<cr>";
            options = {
              desc = "Notes: New note";
              noremap = true;
              silent = true;
            };
          }
          {
            key = "<leader>nt";
            action = "<cmd>ObsidianNewFromTemplate<cr>";
            options = {
              desc = "Notes: New from template";
              noremap = true;
              silent = true;
            };
          }
        ];

        # Ensure completion framework is available for cmp-related plugins
        plugins.cmp.enable = lib.mkForce true;

        # Use legendary/dressing as a different command palette for notes
        # Add legendary from pkgs.vimPlugins via extraPlugins (module not present)
        extraPlugins = with pkgs.vimPlugins; [ legendary-nvim ];
        plugins.dressing.enable = lib.mkForce true;

        # Use kanagawa colorscheme for this notes profile
        frgdNeovim.ui.colorscheme.default = "kanagawa";
      };
    }
  );
  notesScript = pkgs.writeShellScriptBin "notes" ''
    #!/bin/sh
    set -euo pipefail
    NOTES_DIR="/home/justin/notes"
    cd "$NOTES_DIR" || { echo "notes: failed to cd to $NOTES_DIR" >&2; exit 1; }
    exec ${neovimNotes}/bin/nvim ${"\${@:-$NOTES_DIR}"}
  '';
in
stdenv.mkDerivation {
  pname = "neovim-notes";
  version = "0.1.0";
  src = ./.;
  buildInputs = [
    neovimNotes
    notesScript
  ];
  installPhase = ''
    mkdir -p $out/bin
    cp -r ${notesScript}/bin/notes $out/bin/
  '';
  meta = (neovimNotes.meta or { }) // {
    description = "Neovim (notes profile; core, ui, and markdown plugins enabled) with notes launcher";
  };
}
