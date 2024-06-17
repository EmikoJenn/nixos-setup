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
  };
}

