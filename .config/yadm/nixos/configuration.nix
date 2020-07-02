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
  networking.networkmanager.extraConfig = ''
    [connection]
    wifi.wake-on-wlan=ignore
    ethernet.wake-on-lan=ignore
  '';
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/London";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    let sysPack = with pkgs; [ acpi openvpn sysstat pavucontrol powertop psmisc tree lsof pciutils usbutils lm_sensors lshw bind file binutils-unwrapped iotop nox vim neovim ];
        toolsPack = with pkgs; [ bash fish wget httpie git p7zip tmux htop gnupg silver-searcher fzf fd unzip docker_compose yadm shellcheck jq exa ];
        devPack = with pkgs; [ openjdk8 maven scala sbt coursier ammonite gnumake cmake gcc nodejs ];
        editorsPack = with pkgs; [ vscode ];
        xPack = with pkgs; [
          hicolor-icon-theme gnome3.adwaita-icon-theme
          fira-code
          firefox
          okular
          unstable.kitty xorg.xdpyinfo
          keepassx2 keepass
          zoom-us
          # xmonad env
          rofi scrot slock kbdlight xorg.xmodmap xcompmgr compton feh pamixer networkmanager_dmenu networkmanagerapplet stalonetray
          xss-lock notify-osd libnotify ((unstable.polybar.override { pulseSupport = true; })
          .overrideAttrs(old: rec {
            version = "3.4.2+fc42";
            src = fetchFromGitHub {
              owner = old.pname;
              repo = old.pname;
              rev = "fc42da812a3553ae9c82e53d92960d96b8d8d22c";
              sha256 = "0jj80llq8l5fksdngr503ysfj82dnv1pnfqr9y0xawkxpkhsrlff";
              fetchSubmodules = true;
            };
          })
          )
          # glx

          glxinfo
          # theme
          vanilla-dmz
          moka-icon-theme
          iconpack-obsidian
          numix-icon-theme
          elementary-xfce-icon-theme
          capitaine-cursors
        ];
        haskellPack = with pkgs.haskellPackages; [ nvim-hs ghc happy hasktags hlint xmobar stack cabal-install ];
    in sysPack ++ toolsPack ++ xPack ++ haskellPack ++ devPack ++ editorsPack;

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.slock.enable = true;
  programs.light.enable = true;
  programs.fish.enable = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
      exportConfiguration = true;
      layout = "gb";
      # xkbOptions = "eurosign:e";

      # Enable touchpad support.
      libinput.enable = true;
      libinput.naturalScrolling = true;
      libinput.middleEmulation = false;
      libinput.buttonMapping = "1 0 3";
      libinput.accelSpeed = "0.6";
      libinput.disableWhileTyping = true;
    };

    fstrim.enable = true;

  };

  services.upower.enable = true;
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
    extraGroups = ["wheel" "networkmanager" "docker" "video" "audio" ];
    uid = 1000;
  };

  systemd.extraConfig = "DefaultLimitNOFILE=1048576";
  security.pam.loginLimits = [{
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "1048576";
  }];

  environment.homeBinInPath = true;
  environment.etc."systemd/sleep.conf".text = ''
[Sleep]
AllowSuspend=yes
AllowHibernation=no
AllowSuspendThenHibernate=no
AllowHybridSleep=no
SuspendMode=suspend
SuspendState=mem standby freeze
#HibernateMode=platform shutdown
#HibernateState=disk
#HybridSleepMode=suspend platform shutdown
#HybridSleepState=disk
HibernateDelaySec=2430min
'';
}
