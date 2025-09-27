{ lib, pkgs ? import <nixpkgs> {} }:

let
  categories = [ "core" "lsp" "git" "formatting" "search" ];
  gather = cat: builtins.attrNames (builtins.readDir ("../modules/nixvim/" + cat));
  modules = lib.concatLists (map gather categories);
in
{
  config = {
    frgdNeovim = {
      nixvim = lib.listToAttrs (map (m: { name = m; value = { enable = true; }; }) modules);
    };
  };
}
