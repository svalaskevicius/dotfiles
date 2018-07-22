# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/b4da34ca-073f-4e3b-acc3-f90bf082f6af";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  # Supposedly better for the SSD.
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  networking.hostName = "tx-saru-nix"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "latarcyrheb-sun32";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # system
    acpi openvpn sysstat pavucontrol powertop psmisc tree lsof pciutils usbutils lm_sensors lshw
    # nixos
    nox
    # shell + tools
    fish wget httpie git p7zip tmux htop gnupg silver-searcher fzf fd unzip docker_compose yadm shellcheck jq lastpass-cli
    # dev + compilers
    openjdk8 maven scala sbt coursier ammonite gnumake cmake gcc
    # editors
    vim neovim
    (jetbrains.idea-community.override { jdk = pkgs.jetbrains.jdk; })
    # fonts
    fira-code nerdfonts
    # X
    firefox hipchat okular kitty xorg.xdpyinfo skypeforlinux
  ];

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  #

  programs.ssh.startAgent = true;
  programs.ssh.agentTimeout = "8h";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  fonts.fontconfig.enable = true;
  fonts.fontconfig.dpi = 192;
  fonts.fontconfig.antialias = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services = {
    acpid.enable = true;
    xserver = {
      enable = true;
      dpi = 192;
      layout = "gb";
      # xkbOptions = "eurosign:e";

      # Enable touchpad support.
      libinput.enable = true;

      # Enable the Desktop Environment.
      displayManager.gdm.enable = true;

      desktopManager.xterm.enable = false;
      desktopManager.gnome3.enable = true;
      windowManager.xmonad.enable = false;
      windowManager.xmonad.enableContribAndExtras = false;
# desktopManager.default = "none";
#    windowManager.default = "xmonad";
    };
  };

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