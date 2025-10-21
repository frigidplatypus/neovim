{
  lib,
  pkgs,
  inputs,
  neovim-settings ? { },
  neovim-config ? { },
  ...
}:
let
  raw-modules = lib.snowfall.fs.get-default-nix-files-recursive (
    lib.snowfall.fs.get-file "/modules/nixvim"
  );

  # Import module-enable helper and extend lib that we pass into evaluated modules.
  # Inline moduleEnable helper so it is always available when evaluating
  # modules (avoids store path import resolution issues).
  moduleEnable =
    name: moduleBody:
    { lib, config, ... }:
    let
      nm = name;
    in
    {
      options.frgdNeovim.nixvim.${nm}.enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable the ${nm} feature module.";
      };

      config = lib.mkIf (config.frgdNeovim.nixvim.${nm}.enable) moduleBody;
    };

  libForModules = lib // {
    moduleEnable = moduleEnable;
  };

  # Some modules use a local `wrap` helper that returns a function which
  # expects the module args (e.g. older inline wrap patterns). Support both
  # styles by calling the module, and if that returns a function, call it
  # again with the same args to produce the final attrset.
  wrapped-modules = builtins.map (
    raw-module:
    args@{ ... }:
    let
      module = import raw-module;
      initialResult =
        if builtins.isFunction module then
          module (
            args
            // {
              lib = libForModules;
              inherit pkgs;
            }
          )
        else
          module;

      # If the module returned another function (older wrap style), call it
      # with the same args so we end up with an attrset as expected by
      # nixvim.makeNixvimWithModule.
      result = if builtins.isFunction initialResult then initialResult args else initialResult;
    in
    result // { _file = raw-module; }
  ) raw-modules;

  raw-neovim = pkgs.nixvim.makeNixvimWithModule {
    inherit pkgs;

    module = {
      imports = wrapped-modules;

      config = lib.mkMerge [
        {
          _module.args = {
            settings = neovim-settings;
            lib = lib;
          };
        }
        neovim-config
      ];
    };
  };

  neovim = raw-neovim.overrideAttrs (attrs: {
    meta = attrs.meta // {
      platforms = builtins.attrNames inputs.nixvim.legacyPackages;
    };
  });
in
neovim
