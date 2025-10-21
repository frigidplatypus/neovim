{
  description = "Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      # inputs.nixpkgs.follows = "unstable";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # TODO: a todo
  # NOTE: a note
  # WARN: a warning
  # HACK: a hack
  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;

      src = ./.;

      snowfall = {
        namespace = "frgd";
      };

      channels-config.allowUnfree = true;

      alias.packages.default = "neovim";

      overlays = with inputs; [ nixvim.overlays.default ];

      # NOTE: We do not manually list packages here; Snowfall Lib auto-discovers
      # any package directories under packages/. This keeps flake outputs
      # aligned with spec/constitution guidance and avoids drift when adding
      # new variants (e.g. neovim-kanagawa, neovim-minimal, neovim-dev, etc.).

      outputs-builder = channels: {
        formatter = channels.nixpkgs.nixfmt-rfc-style;

        checks.pre-commit-check = inputs.pre-commit-hooks.lib.${channels.nixpkgs.system}.run {
          src = ./.;
          hooks = {
            nixfmt = {
              enable = true;
              entry = "${channels.nixpkgs.nixfmt-rfc-style}/bin/nixfmt";
              extraPackages = [
                channels.nixpkgs.nixfmt-rfc-style
              ];
            };
          };
        };

      };

    };
}
