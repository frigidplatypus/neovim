{
  # Module options scaffold (added by feature 002-modules-should-have)
  # Note: We add the options here as a non-invasive scaffold. During migration
  # modules will be refactored to wrap existing config in `mkIf cfg.enable`.
  # For now, keep existing runtime behavior unchanged.

  # ...existing module configuration...
  plugins.nvim-autopairs = {
    enable = true;

    settings = {
      disable_filetype = ["TelescopePrompt"];
    };
  };

  # Example options block (to be moved to module options during full migration):
  # options.frgdNeovim.nixvim.autopairs = with lib.types; {
  #   enable = lib.mkBoolOpt true "Whether to enable autopairs during migration";
  # };
}
