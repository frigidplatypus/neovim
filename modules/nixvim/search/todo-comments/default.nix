{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "todo-comments" {
  plugins."todo-comments" = { enable = true; };
}
