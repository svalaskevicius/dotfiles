{ stdenv, fetchurl}:

stdenv.mkDerivation rec {
  name = "qca6174_firmware-${version}";
  version = "6";
  src = ./firmware-6.bin_WLAN.RM.4.4.1.c3-00035;
  sourceRoot = ".";
  dontBuild = true;
  unpackPhase = ''
    cp "$src" .
  '';

  installPhase = ''
    mkdir -p "$out/lib/firmware/ath10k/QCA6174/hw3.0"
    cp "$src" "$out/lib/firmware/ath10k/QCA6174/hw3.0/firmware-6.bin"
  '';

  # Firmware blobs do not need fixing and should not be modified
  dontFixup = true;

  meta = with stdenv.lib; {
    description = "Binary firmware for QCA6174 chipset";
    homepage = https://github.com/kvalo/ath10k-firmware;
    license = licenses.unfreeRedistributableFirmware;
    platforms = platforms.linux;
    # priority = 6; # give precedence to kernel firmware
  };

  passthru = { inherit version; };
}
