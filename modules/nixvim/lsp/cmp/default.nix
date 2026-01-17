{
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.frgdNeovim.lsp.cmp;
  helpers =
    if lib ? nixvim && lib.nixvim ? helpers then
      lib.nixvim.helpers
    else
      { mkRaw = value: { __raw = value; }; };
in
{
  options.frgdNeovim.lsp.cmp.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable cmp LSP plugin.";
  };

  config = mkIf cfg.enable {
    plugins = {
      luasnip.enable = true;
      cmp = {
        enable = true;
        cmdline =
          let
            search = {
              mapping = helpers.mkRaw "cmp.mapping.preset.cmdline()";
              sources = [ { name = "buffer"; } ];
            };
          in
          {
            "/" = search;
            "?" = search;
            ":" = {
              mapping = helpers.mkRaw "cmp.mapping.preset.cmdline()";
              sources = [ { name = "cmdline"; } ];
            };
          };
        settings = {
          experimental.ghost_text = true;
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-j>" = "cmp.mapping.scroll_docs(4)";
            "<C-k>" = "cmp.mapping.scroll_docs(-4)";
            "<C-l>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
            "<C-n>" = helpers.mkRaw ''
              function(fallback)
                if cmp.visible() then cmp.select_next_item()
                elseif require("luasnip").expand_or_jumpable() then require("luasnip").expand_or_jump()
                else fallback() end
              end
            '';
            "<C-p>" = helpers.mkRaw ''
              function(fallback)
                if cmp.visible() then cmp.select_prev_item()
                elseif require("luasnip").expand_or_jumpable() then require("luasnip").expand_or_jump()
                else fallback() end
              end
            '';
          };
          snippet.expand = ''function(args) require("luasnip").lsp_expand(args.body) end'';
          sources = [
            { name = "path"; }
            { name = "copilot"; }
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "dictionary"; }
          ];
        };
      };
      copilot-cmp.enable = true;
      cmp-fuzzy-path.enable = true;
      cmp_luasnip.enable = true;
      cmp_yanky.enable = true;
    };
  };
}
