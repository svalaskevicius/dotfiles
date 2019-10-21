{
  pkgs ? import <nixpkgs> {}
}:

(pkgs.buildFHSUserEnv {
  name = "xmonad-x11-env";
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
    ]) ++ ( with pkgs;
[
   gcc
   x11
   xorg.libX11
   xorg.libXext
   xorg.libXinerama
   xorg.libXrandr
   xorg.libXrender
   xorg.libXScrnSaver
   xorg.libXft
   libffi
   pkgconfig
   gmp
   wirelesstools
   alsaLib
   zlib
   xorg.libXpm
 ]   );
  multiPkgs = pkgs: (with pkgs;
    [ udev
      alsaLib
    ]);
}).env
