{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myHomeManager.programs.graphical.blender = {
    enable = lib.mkEnableOption "blender";
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.blender.enable {
    nixpkgs.overlays = [
      (final: prev: {
        blender-rocm = prev.symlinkJoin {
          name = "blender-rocm";
          paths = [prev.pkgsRocm.blender];

          nativeBuildInputs = [prev.makeWrapper];

          postBuild = ''
            wrapProgram $out/bin/blender --set LD_PRELOAD "${prev.rocmPackages.rocm-comgr}/lib/libamd_comgr.so.3"
          '';
        };
      })
    ];

    home.packages = with pkgs; [
      blender-rocm
    ];
  };
}
