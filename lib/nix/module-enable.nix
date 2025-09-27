{ lib }:

# Returns a module fragment function that declares an `enable` option and
# conditionally emits `moduleBody` under `config` when enabled. Intended to
# be imported inside a module file and used like:
# let wrap = import ../../lib/nix/module-enable.nix { inherit lib; }; in
# wrap "modulename" { plugins.foo.enable = true; }

name: moduleBody:
{ lib, config, ... }:
let nm = name; in
{
  options.frgdNeovim.nixvim.${nm}.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable the ${nm} feature module.";
  };

  config = lib.mkIf (config.frgdNeovim.nixvim.${nm}.enable) moduleBody;
}
