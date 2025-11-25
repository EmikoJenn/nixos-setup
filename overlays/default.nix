{ unstablePkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      unstable = unstablePkgs {
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
      };
    })
  ];
}
