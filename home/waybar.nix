{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free";
        font-size: 12px;
        min-height: 0;
      }
      
      window#waybar {
        background: rgba(30, 30, 46, 0.7);
        color: #cdd6f4;
      }
      
      #workspaces button {
        padding: 0 10px;
        background: transparent;
        color: #cdd6f4;
      }
      
      #workspaces button.active {
        background: #585b70;
        border-radius: 4px;
      }
      
      #workspaces button.urgent {
        color: #f38ba8;
      }
      
      #clock, #battery, #network, #pulseaudio, #tray {
        padding: 0 10px;
        margin: 0 4px;
        color: #cdd6f4;
      }
      
      #clock {
        background-color: #585b70;
        border-radius: 4px;
      }
      
      #battery.charging {
        color: #a6e3a1;
      }
      
      #battery.warning:not(.charging) {
        color: #f9e2af;
      }
      
      #battery.critical:not(.charging) {
        color: #f38ba8;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      
      @keyframes blink {
        to {
          background-color: #f38ba8;
          color: #1e1e2e;
        }
      }
    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "network" "pulseaudio" "battery" "clock" "tray" ];
        
        battery = {
          format = "{icon}  {capacity}%";
          format-icons = [ "" "" "" "" "" ];
          states = {
            warning = 30;
            critical = 15;
          };
        };
        
        clock = {
          format = "  {:%H:%M}    {:%d/%m}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        
        network = {
          format-wifi = "  {essid}";
          format-ethernet = "  {ipaddr}/{cidr}";
          format-disconnected = "  Disconnected";
          tooltip-format = "{ifname} via {gwaddr}";
        };
        
        pulseaudio = {
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = "  Muted";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          scroll-step = 5;
          on-click = "pavucontrol";
        };
      };
    };
  };

  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar status bar";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}