{
  services.samba = {
    enable = true;

    settings = {
      global = {
        workgroup = "WORKGROUP";
        security = "user";
        "server min protocol" = "SMB3_11";
        "server smb encrypt" = "required";
        "server signing" = "mandatory";
        "map to guest" = "never";
        "disable netbios" = "yes";
        "smb ports" = "445";
      };

      sh-pmt = {
        path = "/srv/storage/sh-pmt";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "force user" = "sh-pmt";
        "valid users" = "sh-pmt";
        "acl allow execute" = "no";
        "hide unreadable" = "yes";
      };
    };
  };

  users = {
    users.sh-pmt = {
      isNormalUser = true;
      group = "sh-pmt";
    };

    groups.sh-pmt = {};
  };
}
