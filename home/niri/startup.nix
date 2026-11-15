{ ... }:

{
  programs.niri.settings = {
    spawn-at-startup = [
      # Pon lo que quieras que inicie junto a niri.
    ];

    hotkey-overlay = {
      skip-at-startup = true;
    };
  };
}
