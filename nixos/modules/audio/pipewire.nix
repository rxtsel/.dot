{
  # Realtime scheduling (recommended for PipeWire)
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  # Disable PulseAudio to avoid conflicts
  services.pulseaudio.enable = false;
}
