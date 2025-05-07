{ pkgs, ... }:
{
  options.firefox = { };

  config = {
    programs.firefox = {
      enable = true;
    };
  };
}
