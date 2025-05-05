# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  session = "${pkgs.hyprland}/bin/Hyprland";
  username = "leo";
  hostname = "t490";
  editor = "hx";
  browser = "firefox";
in
{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "t490"; # Host name

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  home-manager = {
    extraSpecialArgs = { 
      inherit inputs;
      username = username;
    };
    users = {
      "${username}" = import ./home.nix;
    };
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    font-awesome
    nerd-fonts.space-mono
    nerd-fonts.iosevka
    nerd-fonts.monoid
  ];
  fonts.fontconfig.enable = true;
  
  users.users.leo = {
    isNormalUser = true;
    description = "Leo";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1"; # tell electron apps to use wayland
    EDITOR = editor;
    VISUAL = editor;
    BROWSER = browser;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.graphics.enable = true; # needed for wayland WMs

  environment.systemPackages = with pkgs; [
    # util
    git
    wget
    curl
    emacs

    # general
    dconf
    wl-clipboard
    brightnessctl
    playerctl
    libnotify
    xdg-utils # provides xgd-open and more
    qt5.qtwayland
    qt6.qtwayland
    libappindicator # tray icons
    swaynotificationcenter

    # networking
    networkmanagerapplet
    blueman

    # ui 
    hyprpaper
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = session;
        user = username;
      };

      default_session = {
        command = "${tuigreet} --greeting 'Greetings' --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "greeter";
      };
    };
  };

  system.stateVersion = "24.11";

}
