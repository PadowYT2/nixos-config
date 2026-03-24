{
  flake.nixosModules.remotebuild = {
    nix = {
      distributedBuilds = true;

      settings = {
        max-jobs = 0;
      };

      buildMachines = [
        {
          hostName = "lumina.proxied.host";
          sshUser = "remotebuild";
          sshKey = "/root/.ssh/id_ed25519";
          system = "x86_64-linux";
          protocol = "ssh-ng";
          speedFactor = 10;
          maxJobs = 16;
          supportedFeatures = ["nixos-test" "big-parallel" "kvm"];
          publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUdoOVR1UmhrVTJwQWFNMXBQcm1BcDV4dXE0TlowVXdIckthcmV3eUEyeFM=";
        }
      ];

      extraOptions = ''
        builders-use-substitutes = true
      '';
    };
  };
}
