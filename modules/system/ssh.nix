{ ... }:
{

  flake.nixosModules.ssh =
    { ... }:
    {
      programs.ssh = {
        extraConfig = ''
          Host github.com
            HostName github.com
            User git
            IdentityFile ~/.ssh/github_ed25519
            IdentitiesOnly yes
            AddKeysToAgent yes

          Host *
            ServerAliveInterval 60
            ServerAliveCountMax 3
        '';
      };
    };

}
