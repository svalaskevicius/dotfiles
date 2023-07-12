{
  pkgs ? import <nixpkgs> {}
  , run ? "bash"
}:

(pkgs.buildFHSUserEnv {
  name = "simple-x11-env";
  targetPkgs = pkgs: (with pkgs;
    [ udev
      alsaLib
      which
      stdenv.cc.libc
      glib
      libxml2
      ffmpeg
      libxslt
      libGL
      alsaLib
      fontconfig
      freetype
      pango
      gtk2
      gtk3
      cairo
      gdk-pixbuf
      atk
      zlib
      perl
      ripgrep
      fish

      git
      # adoptopenjdk-hotspot-bin-11
      openjdk11
      maven scala sbt gnumake gcc nodejs coursier
      fira-code
      cudatoolkit linuxPackages.nvidia_x11
    ]) ++ (with pkgs.xorg;
    [ libX11
      libXcursor
      libXrandr
      libXext
      libXtst
      libXi
      libXp
      libXt
      libXrender
      libXxf86vm
    ]);
  multiPkgs = pkgs: (with pkgs;
    [ udev
      alsaLib
    ]);
  runScript = run;
}).env
