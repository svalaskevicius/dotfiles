# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> {
    config = config.nixpkgs.config;
  };
in {
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./local.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.cleanTmpDir = true;

  # Supposedly better for the SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  networking.hosts = {
    "127.0.0.1" = [config.networking.hostName];
  };
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/London";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    let sysPack = with pkgs; [ acpi openvpn sysstat pavucontrol powertop psmisc tree lsof pciutils usbutils lm_sensors lshw bind file binutils-unwrapped iotop nox ];
        toolsPack = with pkgs; [ fish wget httpie git p7zip tmux htop gnupg silver-searcher fzf fd unzip docker_compose yadm shellcheck jq ];
        devPack = with pkgs; [ openjdk8 maven scala sbt coursier ammonite gnumake cmake gcc ];
        editorsPack = with pkgs; [ vim neovim (jetbrains.idea-community.override { jdk = pkgs.jetbrains.jdk; }) ];
        xPath = with pkgs; [
          fira-code nerdfonts
          firefox chromium
          okular
          kitty xorg.xdpyinfo
          keepassx2 keepass
          hipchat zoom-us unstable.skypeforlinux
          # xmonad env
          rofi scrot slock kbdlight xorg.xmodmap xcompmgr compton feh pamixer networkmanager_dmenu networkmanagerapplet
          xss-lock
        ];
        haskellPack = with pkgs.haskellPackages; [ nvim-hs ghc happy hasktags hlint stylish-haskell xmobar stack cabal-install ];
    in sysPack ++ toolsPack ++ devPack ++ editorsPack ++ xPath ++ haskellPack;

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.slock.enable = true;
  programs.light.enable = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  #

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  fonts.fontconfig.enable = true;
  fonts.fontconfig.antialias = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services = {
    acpid.enable = true;
    xserver = {
      enable = true;
      layout = "gb";
      # xkbOptions = "eurosign:e";

      # Enable touchpad support.
      libinput.enable = true;
      libinput.naturalScrolling = true;
      libinput.middleEmulation = false;

      # Enable the Desktop Environment.
      displayManager.gdm.enable = true;

      windowManager.xmonad.enable = true;
      windowManager.xmonad.enableContribAndExtras = true;
      desktopManager.xterm.enable = false;
      desktopManager.gnome3.enable = true;
      desktopManager.default = "gnome3";
#    windowManager.default = "xmonad";
    };

    # Enable network printer
    printing.enable = true;
    avahi.enable = true;
    avahi.nssmdns = true;
    fstrim.enable = true;

    redshift.enable = true;
    redshift.latitude = "51.5074";
    redshift.longitude = "0.1278";


  };

  services.logind.lidSwitch = "suspend";
  services.logind.extraConfig = ''
    IdleAction=suspend
    IdleActionSec=600
    HandlePowerKey=suspend
  '';


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sarunas = {
    isNormalUser = true;
    home = "/home/sarunas";
    shell = pkgs.fish;
    description = "Sarunas Valaskevicius";
    extraGroups = ["wheel" "networkmanager" "docker"];
    uid = 1000;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
