{ config, lib, pkgs, modulesPath, ... }: {
  fileSystems = {
    #"/run/media/emikojenn/Respaldo" = {
      #device = "dev/disk/by-uuid/8472BBDC72BBD0E2";
      #fsType = "ntfs";
      #options = [
        #"users"
	#"nofail"
	#"x-gvfs-show"
      #];
    #};
    #"/run/media/emikojenn/my_life" = {
      #device = "/dev/disk/by-uuid/c0c0f981-2950-4a5e-96a5-57c4637d1357";
      #fsType = "btrfs";
      #options = [
        #"nofail"
	#"x-gvfs-show"
      #];
    #};
    "/run/media/emikojenn/Linux" = {
      device = "/dev/disk/by-uuid/f1e2ec61-ea58-40a7-8ea8-13790927d7f7";
      fsType = "btrfs";
      options = [
        "nofail"
	"x-gvfs-show"
      ];
    };
    "/run/media/emikojenn/Windows" = {
      device = "/dev/disk/by-uuid/04AE23884941B832";
      fsType = "ntfs";
      options = [
        "users"
	"nofail"
	"x-gvfs-show"
      ];
    };
    "/run/media/emikojenn/SSD" = {
      device = "/dev/disk/by-uuid/DE989A199899F06F";
      fsType = "ntfs";
      options = [
        "users"
	"nofail"
	"x-gvfs-show"
      ];
    };
  };
}
