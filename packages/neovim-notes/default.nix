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
        frgdNeovim.ai.codecompanion.enable = false;
        frgdNeovim.ai.copilotChat.enable = false;
        frgdNeovim.ai.copilotLua.enable = false;
        frgdNeovim.formatting.conform.enable = false;
        frgdNeovim.formatting.trim.enable = false;
        frgdNeovim.formatting.ts-context-commentstring.enable = false;
        frgdNeovim.git.diffview.enable = false;
        frgdNeovim.git.gitsigns.enable = false;
        frgdNeovim.git.lazygit.enable = false;
        frgdNeovim.git.neogit.enable = false;
        frgdNeovim.lsp.cmp.enable = false;
        frgdNeovim.lsp.lsp-config.enable = false;
        frgdNeovim.lsp.lsp-format.enable = false;
        frgdNeovim.lsp.lspkind.enable = false;
        frgdNeovim.lsp.none-ls.enable = false;
        frgdNeovim.lsp.otter.enable = false;
        frgdNeovim.lsp.trouble.enable = false;
        frgdNeovim.productivity.auto-session.enable = false;
        frgdNeovim.productivity.comment.enable = false;
        frgdNeovim.productivity.hop.enable = false;
        frgdNeovim.productivity.inc-rename.enable = false;
        frgdNeovim.productivity.navic.enable = false;
        frgdNeovim.productivity.neo-tree.enable = false;
        frgdNeovim.productivity.neoscroll.enable = false;
        frgdNeovim.productivity.oil.enable = false;
        frgdNeovim.productivity.surround.enable = false;
        frgdNeovim.productivity.telescope.enable = false;
        frgdNeovim.productivity.yanky.enable = false;
        frgdNeovim.productivity.wrapping.enable = false;
        frgdNeovim.search.neoclip.enable = false;
        frgdNeovim.search.todo-comments.enable = false;
      };
    }
  );
  notesScript = pkgs.writeShellScriptBin "notes" ''
    exec ${neovimNotes}/bin/nvim ~/notes
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
    cp -r ${neovimNotes}/bin/* $out/bin/
    cp -r ${notesScript}/bin/notes $out/bin/
  '';
  meta = (neovimNotes.meta or { }) // {
    description = "Neovim (notes profile; core, ui, and markdown plugins enabled) with notes launcher";
  };
}
