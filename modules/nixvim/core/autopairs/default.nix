{ lib, ... }:
let wrap = lib.moduleEnable; in
wrap "autopairs" {
  plugins."nvim-autopairs" = {
    enable = true;
  };
  extraConfigLua = ''
    pcall(function()
      local ok, np = pcall(require, 'nvim-autopairs')
      if ok then
        if not (np.__frgd_configured or false) then
          np.setup({})
          np.__frgd_configured = true
        end
      end
    end)
  '';
}
