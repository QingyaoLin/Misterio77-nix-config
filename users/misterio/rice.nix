{ pkgs, config, inputs, hostname, ... }:

with inputs.nix-colors.lib { inherit pkgs; };

let
  currentScheme.atlas = "solarflare";
  currentScheme.pleione = "silk-light";
  currentScheme.merope = "nord";
  currentScheme.maia = "pasque";
  currentWallpaper.atlas = "cubist-orange-blue";
  currentWallpaper.pleione = "cubist-crystal-brown-teal";
  currentMode = null;
in
{
  imports = [ inputs.nix-colors.homeManagerModule ];
  home.packages = with pkgs; [ setscheme setwallpaper ];

  colorscheme =
    if currentScheme.${hostname} != null then
      inputs.nix-colors.colorSchemes.${currentScheme.${hostname}}
    else
      colorschemeFromPicture {
        path = config.wallpaper;
        kind = currentMode;
      };

  wallpaper =
    if currentWallpaper.${hostname} != null then
      pkgs.wallpapers.${currentWallpaper.${hostname}}
    else
      nixWallpaperFromScheme {
        scheme = config.colorscheme;
        width = 2560;
        height = 1080;
        logoScale = 4.5;
      };
}
