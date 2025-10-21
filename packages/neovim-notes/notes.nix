{
  pkgs,
  stdenv,
  lib,
  ...
}:

let
  notes = pkgs.writeShellScriptBin "notes" ''
    ${pkgs.neovim-notes}/bin/nvim ~/notes
  '';
in

stdenv.mkDerivation {
  pname = "notes";
  version = "0.1.0";
  src = ./.;
  buildInputs = [
    pkgs.neovim-notes
    notes
  ];
  installPhase = ''
    mkdir -p $out/bin
    cp -R ${notes}/bin/notes $out/bin/
  '';
}
