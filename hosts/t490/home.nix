{ config, pkgs, lib, builtins, inputs, username, ... }:
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
    ../../modules/home-manager/desktop
    ../../modules/home-manager/firefox
    ../../modules/home-manager/syncthing
    ../../modules/home-manager/editor/helix
    ../../modules/home-manager/sh
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  xdg.enable = true; # required for catppuccin/nix theming
  
  desktop = {
    theme = "dark";
    terminal = lib.getExe config.sh.package;
    #monitors = [
    #  {
    #    name = "DP-1";
    #    width = 2560;
    #    height = 1440;
    #    wallpaper = config.styling.wallpaper;
    #    x = 0;
    #    y = 0;
    #  }
    #];

    lockscreen = {
      wallpaper = config.styling.wallpaper;
      timeout = 120;
    };

    wofi.font = {
      name = config.styling.fontName;
      size = 18;
    };
  };

  sh = {
    terminal = "ghostty";
    shell = "zsh";
  };
  
  kitty = {
    font = {
      name = config.styling.fontName;
      size = 18;
    };
  };

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    curl
    neofetch
    discord
    obsidian
    lazygit
    nil
    ripgrep
    
    file
    killall

    #dev
    cargo
    rustc
  ];

  programs.git = {
    enable = true;
    userName = "LeoArr";
    userEmail = "leopold.arrestrom@gmail.com";
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
    };
  };

  environment.shellAliases = {
    lg = "lazygit";
  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
