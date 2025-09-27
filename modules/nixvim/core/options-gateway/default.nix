{ lib, ... }:
/*
  Temporary dynamic options gateway for Task T013 (mass per-module enable flags).

  Provides: frgdNeovim.nixvim.<module>.enable :: bool

  - <module> is any attribute name (attrsOf submodule) so we don't need to
    predeclare every module yet.
  - Each submodule currently exposes only `enable`; future real modules will
    replace these stubs with richer option sets.
  - Keeps variant package evaluation working (they set many *.enable = true)
    before the bulk transformation lands.

  Removal: delete this file once real module option definitions have been
  generated/hand-authored for all modules (end of T013) and tests updated to
  assert concrete options instead of dynamic gateway presence.
*/
let
  moduleStub = { name, ... }: {
    options.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the ${name} feature module (temporary stub).";
    };

    # No config emitted yet; real modules will produce config when enabled.
  };
in
{
  options.frgdNeovim.nixvim = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule moduleStub);
    default = {};
    description = ''
      (Temporary) Dynamic module enable namespace. Each attribute becomes a
      stub module offering only an `enable` boolean. Replaced by concrete
      option declarations & implementations in Task T013.
    '';
  };
}
