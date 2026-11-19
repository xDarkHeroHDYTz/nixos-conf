{ config, lib, pkgs, ... }:

let
  cfg = config.programs.niri;

  effectsFile = ./effects.kdl;

  combinedConfig = pkgs.runCommand "niri-config-with-effects.kdl" {
    nativeBuildInputs = [ cfg.package ];

    passAsFile = [ "config" ];

    config = ''
      ${cfg.finalConfig}

      // Additional KDL effects.
      include "${effectsFile}"
    '';
  } ''
    niri validate -c "$configPath"
    cp "$configPath" "$out"
  '';
in
{
  xdg.configFile.niri-config.source = lib.mkForce combinedConfig;
}
