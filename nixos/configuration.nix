# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      # apps
      alacritty
      firefox
      rofi
      ranger
      polybar
      spotify
      
      # games
      steam
      minecraft

      # utils
      wget
      git
      killall
      feh
      pavucontrol
      coreutils
      xclip
      fd
      wireguard-tools
      ripgrep

      # editors
      neovim
      emacs

      # languages
      rustup
      ghc
      clang
    ];
    variables = {
      EDITOR = "nvim";
    };
    sessionVariables = rec {
      XDG_BIN_HOME = "$HOME/.local/bin";

      PATH = [
        "${XDG_BIN_HOME}"
        "$HOME/.emacs.d/bin"
      ];
    };
  };

  programs = {
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        theme = "Soliah";
      };
    };
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    scientifica
  ];

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    picom = {
      enable = true;
      fade = true;
      fadeDelta = 4;
      shadow = true;
      shadowExclude = [
        "name = 'Notification'"
	      "class_g = 'Conky'"
        "class_g ?= 'Notify-osd'"
        "class_g = 'Cairo-clock'"
        "_GTK_FRAME_EXTENTS@:c"
        "window_type = 'dock'"
      ];
    };
    xserver = {
      enable = true;
      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+bspwm";
      };
      desktopManager.xfce.enable = false;
      windowManager.bspwm.enable = true;
      layout = "us,ru";
      xkbOptions = "grp:alt_shift_toggle";
      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
      };
      videoDrivers = [ "nvidia" ];
    };
    printing.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.blob = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      neofetch
    ];
  };

  networking = {
    hostName = "tuxuila";
    networkmanager.enable = true;
  };

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  hardware = {
    opengl.enable = true;
    nvidia = {
      modesetting.enable = true;
      forceFullCompositionPipeline = true;
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      gfxmodeEfi = "1920x1080";
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };
  
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

