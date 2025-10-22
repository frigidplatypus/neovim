{
  lib,
  pkgs,
  inputs,
  stdenv,
  ...
}:

let
  neovimNotes = (
    import ../neovim {
      inherit lib pkgs inputs;
      neovim-config = {
        frgdNeovim.ai.enable = lib.mkForce false;
        frgdNeovim.formatting.enable = lib.mkForce false;
        frgdNeovim.git.enable = lib.mkForce false;
        frgdNeovim.lsp.enable = lib.mkForce false;
        frgdNeovim.search.enable = lib.mkForce false;
      };
    }
  );
  notesScript = pkgs.writeShellScriptBin "notes" ''
    exec ${neovimNotes}/bin/nvim ~/notes
  '';
in
stdenv.mkDerivation {
  pname = "neovim-notes";
  version = "0.1.0";
  src = ./.;
  buildInputs = [
    neovimNotes
    notesScript
  ];
  installPhase = ''
    mkdir -p $out/bin
    cp -r ${neovimNotes}/bin/* $out/bin/
    cp -r ${notesScript}/bin/notes $out/bin/
  '';
  meta = (neovimNotes.meta or { }) // {
    description = "Neovim (notes profile; core, ui, and markdown plugins enabled) with notes launcher";
  };
}
