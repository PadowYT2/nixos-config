{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/spark.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/l6YH9Als/versions/v5qtqRQi/spark-1.10.124-neoforge.jar";
        hash = "sha512-+GzjTydZxp34JXjDl/9VtmbIRiYimpj1mEWLlgwhs4yV1r/vR3Kvf5Y8T0ho5eLZrva5nB1RurVb9F4Obmte1A==";
      }}";
    };
  };
}
