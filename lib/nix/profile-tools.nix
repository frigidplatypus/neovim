{ lib, types }:

# Small helper utilities for composing profile module sets
{
  makeModuleSet = moduleList: lib.listToAttrs (map (m: { name = m; value = true; }) moduleList);
}
