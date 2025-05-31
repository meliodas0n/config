#  Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # auto system update
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # Fonts for coding
  fonts.packages = with pkgs; [
    nerdfonts
    # (nerdfonts.override { fonts = ["DejaVuSansM" "MesloLG"]; })
  ];

  # direnv
  programs.direnv.enable = true;

  # hyprland
  programs.hyprland.enable = true;
  
  # bash for all
  users.defaultUserShell = pkgs.bash;
  # bash customization
  # programs.bash.promptInit = ''
    # eval "$(${pkgs.starship}/bin/starship init bash)"
  # '';
  # hardware.opengl = {
    # enable = true;
    # driSupport = true;
    # driSupport32Bit = true;
  # };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
	
  services.blueman.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lostvayne"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.displayManager.gdm.enable = false;
  # services.desktopManager.gnome.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    # xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.meliodas = {
    isNormalUser = true;
    description = "Meliodas";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    #  firefox
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "meliodas";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Docker setup
  # virtualization.docker = {
    # enable = true;
    # rootless = { 
      # enable = true; 
      # setSocketVariable = true; 
    # };
  # };
  
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "meliodas" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type   database    DBuser    origin-address    auth-method
      local   all         all                         trust
      # ipv4
      host    all         all       127.0.0.1/32      trust
      # ipv6
      host    all         all       ::1/128           trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE USER hiveuser WITH LOGIN PASSWORD 'hive' CREATEDB;
      CREATE DATABASE metastore_db;
      GRANT ALL PRIVILEGES ON DATABASE metastore_db TO hiveuser;
      CREATE USER meliodas WITH LOGIN PASSWORD 'kurama' CREATEDB;
      CREATE DATABASE meliodas_db;
      GRANT ALL PRIVILEGES ON DATABASE meliodas_db TO meliodas;
    '';
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # necessary tools
  wget curl git cmake meson gcc tmux htop ranger dolphin obsidian

  # usage
  google-chrome spotify alacritty discord xterm green-pdfviewer

  # editors
  neovim vim vscode
  
  # ricing
  hyprpaper neofetch waybar cava rofi eww wofi dolphin cowsay swaybg
  
  # dev
  rustup nodejs_22 python3 poetry docker postgresql spark hadoop jdk8

  # dev libraries
  # libpq
  
  # gpu ML & DL
  cudatoolkit cudaPackages.cudnn linuxPackages.nvidia_x11 libGLU libGL xorg.libXi xorg.libXmu freeglut xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib ncurses5 stdenv.cc binutils

  # system packages
  pavucontrol pamixer bluez bluez-tools

  # python packages
  (python3.withPackages (subpkgs: with subpkgs; [
    pip 
    virtualenv
    mypy
    requests
    pandas
    numpy 
    pyspark
    django
    flask
    polars
    psycopg2
    jupyterlab
    pytorch 
    # tensorflow
    fastapi
  ]))
  ];

  # jupyterlab systemd service setup
  systemd.services.jupyterlab = {
    description = "Jupyterlab service";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.python3.withPackages (ps: with ps; [ jupyterlab ])}/bin/jupyter lab --no-browser --ip=0.0.0.0 --port=8888 --NotebookApp.token='' --NotebookApp.password=''";
      WorkingDirectory = "/home/meliodas";
      User = "meliodas";
      Restart = "always";
      Environment = "PATH=/run/wrappers/bin:/home/your-username/.nix-profile/bin:/etc/profiles/per-user/your-username/bin:${pkgs.python3}/bin";
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 57621 8888 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  environment.shellAliases = {
    la = "ls -al";
    config = "sudo nvim /etc/nixos/configuration.nix";
    vim = "nvim";
    nixbuild = "sudo nixos-rebuild switch";
    nixclean = "sudo nix-collect-garbage -d";
    nixdel = "sudo nix-env --delete-generations old";
    nixboot = "sudo nixos-rebuild boot";
    p = "python3";
    pip = "pip3";
    activate = "source ~/.local/venv/bin/activate";
  };

  environment.variables = {
    # NPM_CONFIG_PREFIX=/home/meliodas/.npm-global;
    PIP_BREAK_SYSTEM_PACKAGES = "1";
  };
}
