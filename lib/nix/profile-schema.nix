{ lib, types }:

# Minimal profile schema
{
  profileSchema = {
    name = types.str;
    description = types.nullOr types.str;
    modules = types.attrsOf types.bool;
    colorScheme = types.nullOr types.str;
  };
}
