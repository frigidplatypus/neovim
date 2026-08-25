{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.frgdNeovim.productivity.silverbullet;
  silverbullet-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "silverbullet.nvim";
    version = "unstable-2026-08-25";
    src = pkgs.fetchFromGitHub {
      owner = "eyko139";
      repo = "silverbullet.nvim";
      rev = "70f837742af36edb33f3576cb1982d212db9bed1";
      hash = "sha256-4uagubuAZPBZ9CR9htVz4gZc/5I16hA26F9UtsHbqvU=";
    };
  };
  luaString = value: builtins.toJSON value;
in
{
  options.frgdNeovim.productivity.silverbullet = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable silverbullet.nvim for a remote SilverBullet space.";
    };

    defaultSpace = mkOption {
      type = types.str;
      default = "personal";
      description = "Name of the default SilverBullet space.";
    };

    spaceUrl = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "SilverBullet space URL; defaults to SILVERBULLET_URL when unset.";
    };

    tokenEnv = mkOption {
      type = types.str;
      default = "SILVERBULLET_TOKEN";
      description = "Environment variable containing the SilverBullet API token.";
    };
  };

  config = mkIf cfg.enable {
    extraPackages = [ pkgs.curl ];
    extraPlugins = [ silverbullet-nvim ];

    extraConfigLua = ''
      local silverbullet_url = ${
        if cfg.spaceUrl == null then "vim.env.SILVERBULLET_URL" else luaString cfg.spaceUrl
      }
      if silverbullet_url and silverbullet_url ~= "" then
        require("silverbullet").setup({
          default_space = ${luaString cfg.defaultSpace},
          spaces = {
            [${luaString cfg.defaultSpace}] = {
              url = silverbullet_url,
              auth = {
                token_env = ${luaString cfg.tokenEnv},
              },
            },
          },
        })

        vim.keymap.set("n", "<leader>sf", "<cmd>SilverBulletFind<cr>", { desc = "Find SilverBullet page" })
        vim.keymap.set("n", "<leader>ss", "<cmd>SilverBulletSearch<cr>", { desc = "Search SilverBullet pages" })
        vim.keymap.set("n", "<leader>sb", "<cmd>SilverBulletBacklinks<cr>", { desc = "Show SilverBullet backlinks" })
        vim.keymap.set("n", "<leader>sj", "<cmd>SilverBulletJournal<cr>", { desc = "Open SilverBullet journal" })
        vim.keymap.set("n", "<leader>sk", "<cmd>SilverBulletSetToken<cr>", { desc = "Set SilverBullet token" })

        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = "silverbullet://*",
          callback = function(event)
            vim.keymap.set("n", "<CR>", "<Plug>(SilverBulletFollowLink)", {
              buffer = event.buf,
              desc = "Follow SilverBullet link",
            })
          end,
        })
      end
    '';
  };
}
