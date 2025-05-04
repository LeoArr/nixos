{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      background_opacity = "0.9";
      dynamic_background_opacity = "yes";
    };
    themeFile = "Catppuccin-Mocha";
    extraConfig = ''
      # Disable window decorations
      hide_window_decorations titlebar-only
      
      # Custom keybindings
      map ctrl+shift+v paste_from_clipboard
      map ctrl+shift+c copy_to_clipboard
    '';
  };
}