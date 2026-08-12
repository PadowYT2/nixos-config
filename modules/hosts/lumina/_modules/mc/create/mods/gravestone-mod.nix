{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/gravestone-neoforge-1.21.1-1.0.38.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/RYtXKJPr/versions/3a6KIbgL/gravestone-neoforge-1.21.1-1.0.38.jar";
        hash = "sha512-7pe1SrnDPK++I2x6mAUpjfqyAEuflBRM5lbpkpg57ppQ8pzftN/96Ftk+qXjwPmJqs7kIEwtDwypuAv9/+XRLg==";
      }}";
    };
  };
}
