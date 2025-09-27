{ pkgs }:
{
  # Map our module option names to actual plugin derivations.
  autopairs = pkgs.vimPlugins.nvim-autopairs or null;
  "which-key" = pkgs.vimPlugins.which-key or null;
  treesitter = pkgs.vimPlugins.nvim-treesitter or null;
}
