{...}: {
  flake.modules.nixos.systemAudio = {
    # Realtime scheduling (recommended for PipeWire)
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber = {
        enable = true;

        extraConfig."10-bluez" = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.roles" = [
              "a2dp_source"
              "bap_source"
              "hsp_hs"
              "hfp_hf"
            ];
          };
        };
      };
      jack.enable = true;
    };

    # Disable PulseAudio to avoid conflicts
    services.pulseaudio.enable = false;
  };
}
