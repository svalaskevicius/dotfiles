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
      libav_0_8
      ffmpeg
      libxslt
      libGL
      alsaLib
      fontconfig
      freetype
      pango
      gtk2
      cairo
      gdk_pixbuf
      atk
      zlib

      git
      openjdk8 maven scala sbt gnumake gcc nodejs
      fira-code
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
