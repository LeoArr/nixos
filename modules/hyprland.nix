{ config, pkgs, lib, hyprland, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    extraConfig = ''
      # Monitor configuration
      monitor=,preferred,auto,1

      # Autostart
      exec-once = waybar
      exec-once = mako
      exec-once = swayidle -w timeout 300 'swaylock -f' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'swaylock -f'
      exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

      # Input configuration
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =
          follow_mouse = 1
          touchpad {
              natural_scroll = yes
          }
          sensitivity = 0
      }

      general {
          gaps_in = 5
          gaps_out = 10
          border_size = 2
          col.active_border = rgba(ca9ee6ff) rgba(f2d5cfff) 45deg
          col.inactive_border = rgba(b4befecc) rgba(6c7086cc) 45deg
          layout = dwindle
          allow_tearing = false
      }

      decoration {
          rounding = 10
          blur {
              enabled = true
              size = 3
              passes = 1
              new_optimizations = on
          }
          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          pseudotile = yes
          preserve_split = yes
      }

      master {
          new_is_master = true
      }

      gestures {
          workspace_swipe = on
      }

      misc {
          force_default_wallpaper = 0
          disable_hyprland_logo = true
      }

      # Window rules
      windowrule = float, ^(pavucontrol)$
      windowrule = float, ^(blueman-manager)$
      windowrule = float, ^(nm-connection-editor)$
      windowrule = float, ^(org.gnome.Calculator)$

      # Key bindings
      $mainMod = SUPER

      # Applications
      bind = $mainMod, RETURN, exec, kitty
      bind = $mainMod, Q, killactive,
      bind = $mainMod SHIFT, M, exit,
      bind = $mainMod, E, exec, nautilus
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, F, fullscreen,
      bind = $mainMod, D, exec, wofi --show drun

      # Screenshot
      bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
      bind = $mainMod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy

      # Media controls
      bind = , XF86AudioPlay, exec, playerctl play-pause
      bind = , XF86AudioNext, exec, playerctl next
      bind = , XF86AudioPrev, exec, playerctl previous

      # Volume controls
      bind = , XF86AudioMute, exec, pamixer -t
      bind = , XF86AudioLowerVolume, exec, pamixer -d 5
      bind = , XF86AudioRaiseVolume, exec, pamixer -i 5

      # Brightness controls
      bind = , XF86MonBrightnessUp, exec, brightnessctl set +5%
      bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-

      # Move focus
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to workspace
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through workspaces
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
    '';
  };

  systemd.user.services = {
    hyprland = {
      Unit = {
        Description = "Hyprland Wayland compositor";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${hyprland.packages.${pkgs.system}.hyprland}/bin/Hyprland";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}