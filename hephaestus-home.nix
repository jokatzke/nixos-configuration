{ config, pkgs, ... }:
let
  user = "yusu";
  maildir = "/home/yusu/.mail";
  name = "Jonas Opitz";

in {

home.username = "${user}";
home.homeDirectory = "/home/${user}";

home.stateVersion = "22.05";

home = {
  sessionPath = [
    "/home/${user}/.emacs.d/bin"
    "/home/${user}/.local/bin"
  ];
};

xdg.configFile."scripts" = {
  source = ./scripts;
  recursive = true;
};

programs.alacritty = {
  enable = true;
  settings = {
    font = {
      normal = {
        family = "Fira Code Nerd Font";
        style = "Retina";
      };
      bold = {
        family = "Fira Code Nerd Font";
        style = "Bold";
      };
      size = 11;
    };
    colors = {
      primary = {
        background = "0x242730";
        foreground = "0xbbc2cf";
      };
      normal = {
        black = "0x242730";
        red = "0xff6c6b";
        green = "0x98be65";
        yellow = "0xecbe7b";
        blue = "0x51afef";
        magenta = "0xc678dd";
        cyan = "0x46d9ff";
        white = "0xbbc2cf";
      };
    };
  };
};

programs.autorandr = {
  enable = true;
  profiles = {
    "three_sub_cloned" = {
      fingerprint = {
        DP-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        DVI-D-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        HDMI-0 = "00ffffffffffff004c2d6f07354332422c14010380331d782aee91a3544c99260f5054bfef80714f8100814081809500950fa940b300023a801871382d40582c4500fd1e1100001e011d007251d01e206e285500fd1e1100001e000000fd00324b1f5111000a202020202020000000fc00534d4258323333310a2020202001cb02031cf14890041f0514131203230907078301000066030c00100080011d80d0721c1620102c2580fd1e1100009e011d8018711c1620582c2500fd1e1100009e011d00bc52d01e20b8285540fd1e1100001e8c0ad090204031200c405500fd1e110000188c0ad08a20e02d10103e9600fd1e110000180000000000000000004c";
      };
      config = {
        DP-1 = {
          enable = false;
        };
        DP-2 = {
          enable = false;
        };
        DP-3 = {
          enable = false;
        };
        DP-4 = {
          enable = false;
        };
        DP-5 = {
          enable = false;
        };
        DP-0 = {
          crtc = 0;
          mode = "2560x1080";
          position = "0x0";
          primary = true;
          rate = "59.98";
          # x-prop-non_desktop = 0;
        };
        DVI-D-0 = {
          crtc = 1;
          mode = "1920x1080";
          position = "2560x726";
          rate = "60.00";
          # x-prop-non_desktop = 0;
        };
        HDMI-0 = {
          crtc = 2;
          mode = "1920x1080";
          position = "2560x726";
          rate = "60.00";
          # x-prop-non_desktop = 0;
        };
      };
    };
    "three_no_ultrawide" = {
      fingerprint = {
        DP-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        DVI-D-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        HDMI-0 = "00ffffffffffff004c2d6f07354332422c14010380331d782aee91a3544c99260f5054bfef80714f8100814081809500950fa940b300023a801871382d40582c4500fd1e1100001e011d007251d01e206e285500fd1e1100001e000000fd00324b1f5111000a202020202020000000fc00534d4258323333310a2020202001cb02031cf14890041f0514131203230907078301000066030c00100080011d80d0721c1620102c2580fd1e1100009e011d8018711c1620582c2500fd1e1100009e011d00bc52d01e20b8285540fd1e1100001e8c0ad090204031200c405500fd1e110000188c0ad08a20e02d10103e9600fd1e110000180000000000000000004c";
      };
      config = {
        DP-1 = {
          enable = false;
        };
        DP-2 = {
          enable = false;
        };
        DP-3 = {
          enable = false;
        };
        DP-4 = {
          enable = false;
        };
        DP-5 = {
          enable = false;
        };
        DP-0 = {
          enable = false;
        };
        DVI-D-0 = {
          crtc = 1;
          mode = "1920x1080";
          position = "0x0";
          rate = "60.00";
          # x-prop-non_desktop = 0;
        };
        HDMI-0 = {
          crtc = 2;
          mode = "1920x1080";
          position = "0x0";
          rate = "60.00";
          # x-prop-non_desktop = 0;
        };
      };
    };
    "three_only_ultrawide" = {
      fingerprint = {
        DP-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        DVI-D-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        HDMI-0 = "00ffffffffffff004c2d6f07354332422c14010380331d782aee91a3544c99260f5054bfef80714f8100814081809500950fa940b300023a801871382d40582c4500fd1e1100001e011d007251d01e206e285500fd1e1100001e000000fd00324b1f5111000a202020202020000000fc00534d4258323333310a2020202001cb02031cf14890041f0514131203230907078301000066030c00100080011d80d0721c1620102c2580fd1e1100009e011d8018711c1620582c2500fd1e1100009e011d00bc52d01e20b8285540fd1e1100001e8c0ad090204031200c405500fd1e110000188c0ad08a20e02d10103e9600fd1e110000180000000000000000004c";
      };
      config = {
        DP-1 = {
          enable = false;
        };
        DP-2 = {
          enable = false;
        };
        DP-3 = {
          enable = false;
        };
        DP-4 = {
          enable = false;
        };
        DP-5 = {
          enable = false;
        };
        DP-0 = {
          crtc = 0;
          mode = "2560x1080";
          position = "0x0";
          primary = true;
          rate = "59.98";
          # x-prop-non_desktop = 0;
        };
        DVI-D-0 = {
          enable = false;
        };
        HDMI-0 = {
          crtc = 2;
          mode = "1920x1080";
          position = "0x0";
          rate = "60.00";
          # x-prop-non_desktop = 0;
        };
      };
    };
    "two_default" = {
      fingerprint = {
        DP-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        DVI-D-0 = "00ffffffffffff004c2d6f07354332422c14010380331d782aee91a3544c99260f5054bfef80714f8100814081809500950fa940b300023a801871382d40582c4500fd1e1100001e011d007251d01e206e285500fd1e1100001e000000fd00324b1f5111000a202020202020000000fc00534d4258323333310a2020202001cb02031cf14890041f0514131203230907078301000066030c00100080011d80d0721c1620102c2580fd1e1100009e011d8018711c1620582c2500fd1e1100009e011d00bc52d01e20b8285540fd1e1100001e8c0ad090204031200c405500fd1e110000188c0ad08a20e02d10103e9600fd1e110000180000000000000000004c";
      };
      config = {
        DP-1 = {
          enable = false;
        };
        HDMI-0 = {
          enable = false;
        };
        DP-2 = {
          enable = false;
        };
        DP-3 = {
          enable = false;
        };
        DP-4 = {
          enable = false;
        };
        DP-5 = {
          enable = false;
        };
        DP-0 = {
          enable = true;
          crtc = 0;
          mode = "2560x1080";
          position = "0x0";
          primary = true;
          rate = "74.99";
        };
        DVI-D-0 = {
          enable = true;
          crtc = 1;
          mode = "1920x1080";
          position = "2560x667";
          rate = "60.00";
        };
      };
    };
    "two_rotated_ultrawide" = {
      fingerprint = {
        DP-0 = "00ffffffffffff001e6dfa76913906000b1b0104a55022789fca95a6554ea1260f5054256b807140818081c0a9c0b300d1c08100d1cfcd4600a0a0381f4030203a001e4e3100001a003a801871382d40582c4500132a2100001e000000fd00284b5a5a18010a202020202020000000fc004c4720554c545241574944450a0125020314712309060747100403011f1312830100008c0ad08a20e02d10103e96001e4e31000018295900a0a038274030203a001e4e3100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ae";
        DVI-D-0 = "00ffffffffffff004c2d6f07354332422c14010380331d782aee91a3544c99260f5054bfef80714f8100814081809500950fa940b300023a801871382d40582c4500fd1e1100001e011d007251d01e206e285500fd1e1100001e000000fd00324b1f5111000a202020202020000000fc00534d4258323333310a2020202001cb02031cf14890041f0514131203230907078301000066030c00100080011d80d0721c1620102c2580fd1e1100009e011d8018711c1620582c2500fd1e1100009e011d00bc52d01e20b8285540fd1e1100001e8c0ad090204031200c405500fd1e110000188c0ad08a20e02d10103e9600fd1e110000180000000000000000004c";
      };
      config = {
        DP-1 = {
          enable = false;
        };
        DP-2 = {
          enable = false;
        };
        DP-3 = {
          enable = false;
        };
        DP-4 = {
          enable = false;
        };
        DP-5 = {
          enable = false;
        };
        DP-0 = {
          crtc = 0;
          mode = "2560x1080";
          position = "0x0";
          primary = true;
          rate = "74.99";
          rotate = "left";
          # x-prop-non_desktop = 0;
        };
        DVI-D-0 = {
          crtc = 1;
          mode = "1920x1080";
          position = "1080x1285";
          rate = "60.00";
          # x-prop-non_desktop = 0;
        };
        HDMI-0 = {
          enable = false;
        };
      };
    };
  };
};

programs.rbw = {
  enable = true;
  settings = import ./.secrets/bitwarden_settings.nix;
};

programs.direnv = {
  enable = true;
  nix-direnv = {
    enable = true;
  };
};

programs.emacs = {
  enable = true;
  package = pkgs.emacs-gtk;
};
services.emacs = {
  enable = true;
  package = pkgs.emacs-gtk;
  defaultEditor = true;
};

home.file.".doom.d" = {
  source = ./doom;
  recursive = true;
};

services.dunst = {
  enable = true;
};

accounts.email = {
  maildirBasePath = "${maildir}";
  accounts = import ./.secrets/email_accounts.nix;
};

programs = {
  msmtp.enable = true;
  mbsync.enable = true;
};

services = {
  mbsync = {
    enable = true;
    # frequency = "*:0/5";
    preExec = "${pkgs.isync}/bin/mbsync -Ha";
    postExec = "${pkgs.mu}/bin/mu index -m ${maildir}";
  };
};

programs.firefox = {
  enable = true;
  # enableGnomeExtensions = true;
};

# Configuration of Fish
programs.fish = {
  enable = true;

interactiveShellInit = ''
  freshfetch
  # Emulates vim's cursor shape behavior
  # Set the normal and visual mode cursors to a block
  set fish_cursor_default block blink
  # Set the insert mode cursor to a line
  set fish_cursor_insert line blink
  # Set the replace mode cursor to an underscore
  set fish_cursor_replace_one underscore blink
  # The following variable can be used to configure cursor shape in
  # visual mode, but due to fish_cursor_default, is redundant here
  set fish_cursor_visual block blink
'';

shellAliases = {
  # make df outputs human readable
  df = "df -h";
  # show sizes in human reabable format
  free = "free -h";
  # confirm before overriding something when copying
  cp = "cp -i";
  # make ls look nices
  ls = "exa -l --color=always --group-directories-first";
  # ledger budget alias
  budget="ledger --empty -f ~/ledger/main.ledger bal ^budget -X EUR";
  # emacs as a client, whilst swallowing the terminal
  em="devour emacsclient -c";
  # interactively cd utilizing fasd
  # cdz="cd (fasd -dl | grep -iv cache | fzf 2>/dev/tty --no-sort --tac)";
  # always ignore the given options when running autorandr
  autorandr="autorandr --skip-options x-prop-non_desktop";
};

functions = {
  fish_user_key_bindings = {
    body = ''
      fish_vi_key_bindings
      for mode in insert default visual
        bind -M $mode \cf forward-char
      end
    '';
  };
};

plugins = [
  # autopair.fish adds automatic completion of paratheses, colons, etc.
  {
    name = "autopair.fish";
    src = pkgs.fetchFromGitHub {
      owner = "jorgebucaran";
      repo = "autopair.fish";
      rev = "1.0.4";
      sha256 = "sha256-s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU=";
    };
  }
  # fasd integration for fish
  # {
  #   name = "fasd";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "oh-my-fish";
  #     repo = "plugin-fasd";
  #     rev = "38a5b6b6011106092009549e52249c6d6f501fba";
  #     sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
  #   };
  # }
];

};

programs.starship = {
  enable = true;
  enableFishIntegration = true;
  settings = {
    add_newline = false;
    username = {
      style_user = "green bold";
      style_root = "red bold";
      format = "[$user]($style) ";
      disabled = false;
      show_always = true;
    };
    hostname = {
      ssh_only = false;
      format = "on [$hostname](bold yellow) ";
      trim_at = ".";
      disabled = false;
    };
    directory = {
      read_only = " 🔒";
      truncation_length = 10;
      truncate_to_repo = true;
      style = "bold italic blue";
    };
  };
};

services.gammastep = {
  enable = false;
  latitude  = 52.5;
  longitude = 13.4;
  temperature = {
    day   = 6500;
    night = 3500;
  };
  tray = true;
  settings = {
    general = {
      fade = 1;
      brigtness-day    = 1.0;
      brightness-night = 0.9;
      gamma-day   = 1.0;
      gamma-night = 0.9;
    };
  };
};

programs.gpg = {
  enable = true;
};

services.gpg-agent = {
  enable = true;
  pinentryFlavor = "qt";
};

services.kdeconnect = {
  enable = true;
  indicator = true;
};

programs.mangohud = {
  enable = true;
  enableSessionWide = false;
  settingsPerApplication = {
    mpv = {
      no_display = true;
    };
  };
};

xsession.numlock.enable = true;

programs.obs-studio = {
  enable = true;
};

services.picom = {
  enable = true;
  backend = "glx";
  vSync = true;
  opacityRules = [
    "95:class_g = 'Alacritty' && focused"
    "80:class_g = 'Alacritty' && !focused"
    "95:class_g = 'Emacs' && focused"
    "80:class_g = 'Emacs' && !focused"
    "95:class_g = 'TelegramDesktop' && focused"
    "80:class_g = 'TelegramDesktop' && !focused"
    "95:class_g = 'Slack' && focused"
    "80:class_g = 'Slack' && !focused"
    "95:class_g = 'Mattermost' && focused"
    "80:class_g = 'Mattermost' && !focused"
    "80:class_g = 'Rofi' && focused"
    "80:class_g = 'Rofi' && !focused"
    "95:class_g = 'Element' && focused"
    "80:class_g = 'Element' && !focused"
    "95:class_g = 'Signal' && focused"
    "80:class_g = 'Signal' && !focused"
    "95:class_g = 'Spotify' && focused"
    "80:class_g = 'Spotify' && !focused"
    "95:class_g = 'Anki' && focused"
    "80:class_g = 'Anki' && !focused"
  ];
};

xdg.configFile."qtile" = {
  source = ./qtile;
  recursive = true;
};

programs.rofi = {
  enable = true;
  font = "Fira Code Nerd Font 10";
  terminal = "alacritty";
  theme = "glue_pro_blue";
  cycle = true;
  extraConfig = {
    modi = "window,drun,ssh,combi";
    combi-modi = "window,drun,ssh";
    show-icons = true;
    icon-theme = "Nerd Icons";
    drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
    disable-history = false;
    sidebar-mode = false;
  };
};

xdg.configFile."river" = {
  source = ./river;
  recursive = true;
};

home.file."river_wrapper" = {
  target = ".local/bin/wrapped_river";
  text = ''
    export _JAVA_AWT_WM_NONREPARENTING=1
    export XCURSOR_SIZE=24
    export LIBVA_DRIVER_NAME=nvidia
    export XDG_SESSION_TYPE=wayland
    export GBM_BACKEND=nvidia-drm
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export WLR_NO_HARDWARE_CURSORS=1
    
    river
  '';
  executable = true;
};

services.kanshi = {
  enable = true;
  profiles = {
    default = {
      outputs = [
        {
          criteria = "DP-1";
          mode = "2560x1080@75";
        }
        {
          criteria = "DVI-D-1";
          mode = "1920x1080@60";
        }
      ];
    };
  };
};

home.file.".vale.ini" = {
  text = ''
    StylesPath = ".vale"
    MinAlertLevel = suggestion # suggestion, warning or error
    
    # the file formats to use
    [*.{md,txt,org}]
    # List of styles to load.
    BasedOnStyles = proselint
  '';
};

home.file.".vale" = {
  source = pkgs.fetchFromGitHub {
    owner = "errata-ai";
    repo = "proselint";
    rev = "acedc7cb5400c65201ff06382ff0ce064bc338cb";
    sha256 = "sha256-faeWr1bRhnKsycJY89WqnRv8qIowUmz3EQvDyjtl63w=";
  };
};

programs.zoxide = {
  enable = true;
  enableFishIntegration = true;
};

nixpkgs.config.allowUnfree = true;
home.packages = [
  pkgs.libreoffice-fresh
  
  pkgs.thunderbird
  pkgs.mattermost-desktop
  pkgs.element-desktop
  pkgs.zoom-us
  pkgs.librewolf
  pkgs.discord
  pkgs.heroic
  pkgs.gamescope
  pkgs.yuzu-mainline
  pkgs.prismlauncher
  pkgs.protonup-ng
  pkgs.spotify
  pkgs.jellyfin-media-player
  pkgs.yacreader
  pkgs.okular
  pkgs.transgui
  pkgs.playerctl
  pkgs.pamixer
  pkgs.pavucontrol
  pkgs.exa
  pkgs.fzf
  pkgs.glances
  pkgs.mullvad
  pkgs.devour
  pkgs.zip
  pkgs.unzip
  # screenshots
  pkgs.libsForQt5.spectacle
  # qt-based pin entry
  pkgs.pinentry_qt
  (let
    tex = (pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-small dvisvgm dvipng # for preview and export as html
        latexmk wrapfig amsmath ulem hyperref capt-of xpatch csquotes biblatex
        placeins algorithm2e ifoddpage relsize
        # for CV:
        pdfx xmpincl fontawesome5 tcolorbox environ enumitem dashrule changepage
        multirow ifmtarg paracol lato fontaxes
        # another cv document class, with a cover letter
        limecv xstring titlesec textpos;
    });
  in tex) pkgs.biber pkgs.texlab
  # general
  pkgs.fd
  pkgs.ripgrep
  pkgs.sqlite
  # emacs everywhere
  pkgs.xorg.xwininfo
  pkgs.xdotool
  pkgs.xclip
  # nix formatter
  pkgs.nixfmt
  # shell formatting / linting
  pkgs.shfmt
  pkgs.shellcheck
  # C compiler e.g. to compile EmacSQL
  pkgs.gcc
  # for the email client mu4e
  pkgs.mu
  pkgs.isync
  # plain text accounting
  pkgs.ledger
  # spellcheckers
  pkgs.hunspell
  pkgs.hunspellDicts.de_DE
  pkgs.hunspellDicts.en_US
  pkgs.vale
  pkgs.feh
  pkgs.freshfetch
  pkgs.rofi
];

}
