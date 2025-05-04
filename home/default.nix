{ config, pkgs, lib, hyprland, ... }:

{
  imports = [
    ./hyprland.nix
    ./kitty.nix
    ./waybar.nix
    ./gtk-qt.nix
  ];

  home.username = "leo";
  home.homeDirectory = "/home/leo";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GDK_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };

  home.packages = with pkgs; [
    # Utilities
    wofi
    swaylock
    swayidle
    grim
    slurp
    wl-clipboard
    mako
    libnotify
    pamixer
    brightnessctl
    playerctl
    
    # Apps
    firefox-wayland
    nautilus
    vscode
    
    # Themes
    catppuccin-gtk
    papirus-icon-theme
    bibata-cursors
  ];
}