{
  nixpkgs.overlays = [
    (final: prev: {
      unstable = unstablePkgs;
    })
  ];
}
