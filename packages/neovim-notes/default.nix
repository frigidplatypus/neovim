{
  lib,
  pkgs,
  inputs,
  ...
}:
## neovim-notes variant
## Enables core, ui, and markdown-related plugins for note-taking and writing.
let
  base = import ../neovim {
    inherit lib pkgs inputs;
    neovim-config = {
      # Disable all non-core, non-ui, non-markdown plugins
      # AI
      frgdNeovim.ai.codecompanion.enable = false;
      frgdNeovim.ai.copilotChat.enable = false;
      frgdNeovim.ai.copilotLua.enable = false;

      # Formatting
      frgdNeovim.formatting.conform.enable = false;
      frgdNeovim.formatting.trim.enable = false;
      frgdNeovim.formatting.ts-context-commentstring.enable = false;

      # Git
      frgdNeovim.git.diffview.enable = false;
      frgdNeovim.git.gitsigns.enable = false;
      frgdNeovim.git.lazygit.enable = false;
      frgdNeovim.git.neogit.enable = false;

      # LSP
      frgdNeovim.lsp.cmp.enable = false;
      frgdNeovim.lsp.lsp-config.enable = false;
      frgdNeovim.lsp.lsp-format.enable = false;
      frgdNeovim.lsp.lspkind.enable = false;
      frgdNeovim.lsp.none-ls.enable = false;
      frgdNeovim.lsp.otter.enable = false;
      frgdNeovim.lsp.trouble.enable = false;

      # Productivity
      frgdNeovim.productivity.auto-session.enable = false;
      frgdNeovim.productivity.comment.enable = false;
      frgdNeovim.productivity.hop.enable = false;
      frgdNeovim.productivity.inc-rename.enable = false;
      frgdNeovim.productivity.navic.enable = false;
      frgdNeovim.productivity.neo-tree.enable = false;
      frgdNeovim.productivity.neoscroll.enable = false;
      frgdNeovim.productivity.oil.enable = false;
      frgdNeovim.productivity.surround.enable = false;
      frgdNeovim.core.telescope.enable = false;
      frgdNeovim.productivity.yanky.enable = false;
      frgdNeovim.productivity.wrapping.enable = false; # Set to true if you want wrapping for markdown

      # Search
      frgdNeovim.search.neoclip.enable = false;
      frgdNeovim.search.todo-comments.enable = false;

    };
  };
in
base.overrideAttrs (old: {
  pname = "neovim-notes";
  meta = (old.meta or { }) // {
    description = "Neovim (notes profile; core, ui, and markdown plugins enabled)";
  };
})
