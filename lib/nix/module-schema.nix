{ lib, types }:

# Minimal module schema for tests
{
  moduleSchema = {
    name = types.str;
    category = types.enum [ "ai" "core" "ui" "productivity" "git" "lsp" "formatting" "search" "utilities" ];
    enable = types.bool;
    dependencies = types.listOf types.str;
    description = types.str;
  };
}
