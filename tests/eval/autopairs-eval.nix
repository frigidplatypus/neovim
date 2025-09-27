{ enable ? true }:
let
  pkgs = import <nixpkgs> { }; # impure for test context; acceptable for lightweight eval test
  lib = pkgs.lib;
  autopairsModule = import ../../modules/nixvim/core/autopairs/default.nix;
  probe = { lib, config, ... }: {
    options._diagnostics.autopairsPresent = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "(test) Whether the autopairs plugin was emitted";
    };
    config._diagnostics.autopairsPresent = lib.mkIf (config ? plugins && builtins.hasAttr "nvim-autopairs" config.plugins) (
      (builtins.getAttr "nvim-autopairs" config.plugins).enable or false
    );
  };
  eval = lib.evalModules {
    modules = [
      { _module.args = { inherit lib pkgs; }; }
      # Stub plugin option namespace so module's config.plugins.nvim-autopairs is accepted
      { options.plugins.nvim-autopairs.enable = lib.mkOption { type = lib.types.bool; default = false; description = "(test stub) autopairs plugin enable"; }; }
      { config.frgdNeovim.nixvim.autopairs.enable = enable; }
      autopairsModule
      probe
    ];
  };
in {
  autopairsPresent = eval.config._diagnostics.autopairsPresent or false;
}
