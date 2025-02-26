{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    nixfmt-rfc-style
  ];

  extraPlugins = with pkgs.vimPlugins; [
    actions-preview-nvim
  ];

  extraConfigLua = ''
    	vim.api.nvim_create_autocmd("LspAttach", {
       callback = function(args)
         local client = vim.lsp.get_client_by_id(args.data.client_id)
         client.server_capabilities.semanticTokensProvider = nil
       end,
     });
  '';

  autoCmd = [
    {
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [
        "*.txt"
        "*.md"
        "*.tex"
        "LICENSE"
      ];
      command = "setlocal spell";
    }
  ];

  plugins.lsp = {
    enable = true;
    inlayHints = true;

    keymaps = {
      silent = true;

      diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };

      lspBuf = {
        K = "hover";
        gh = "hover";
        gr = "references";
        gd = "definition";
        gi = "implementation";
        gD = "type_definition";
      };

    };

    servers = {
      cssls.enable = true;
      docker_compose_language_service.enable = true;
      nginx_language_server.enable = true;
      bashls.enable = true;
      marksman.enable = true;
      perlpls.enable = true;
      #fish_lsp.enable = true;
      openscad_lsp.enable = true;
      nixd = {
        enable = true;

        settings = {
          nixpkgs = {
            expr = "import <nixpkgs> {}";
          };
          formatting = {
            command = [ "nixpkgs-fmt" ];
          };
          options = {
            nixos = {
              expr = ''
                let configs = (builtins.getFlake ("git+file://" + builtins.toString ./.)).nixosConfigurations; in (builtins.head (builtins.attrValues configs)).options
              '';
            };
            home_manager = {
              expr = ''
                let configs = (builtins.getFlake ("git+file://" + builtins.toString ./.)).homeConfigurations; in (builtins.head (builtins.attrValues configs)).options
              '';
            };
            darwin = {
              expr = ''
                let configs = (builtins.getFlake ("git+file://" + builtins.toString ./.)).darwinConfigurations; in (builtins.head (builtins.attrValues configs)).options
              '';
            };
          };
        };
      };
      yamlls.enable = true;
    };
  };
}
