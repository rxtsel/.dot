{ ... }:
{

  flake.nixosModules.ssh =
    { config, ... }:
    {
      programs.ssh = {
        extraConfig = ''
          Host github.com
            HostName github.com
            User git
            IdentityFile ${config.preferences.user.sshIdentityFile}
            IdentitiesOnly yes
            AddKeysToAgent yes

          Host *
            ServerAliveInterval 60
            ServerAliveCountMax 3
        '';
      };
    };

}
