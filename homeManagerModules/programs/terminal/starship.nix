{
  lib,
  config,
  ...
}: {
  options.myHomeManager.programs.terminal.starship = {
    enable = lib.mkEnableOption "starship";
  };

  config = lib.mkIf config.myHomeManager.programs.terminal.starship.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        add_newline = false;
        line_break.disabled = true;
        os = {
          disabled = false;
          style = "bold blue";
          symbols = {
            AlmaLinux = " ";
            Alpaquita = " ";
            Alpine = " ";
            Amazon = " ";
            Android = " ";
            Arch = " ";
            Artix = " ";
            CachyOS = " ";
            CentOS = " ";
            Debian = " ";
            DragonFly = " ";
            Emscripten = " ";
            EndeavourOS = " ";
            Fedora = " ";
            FreeBSD = " ";
            Garuda = "󰛓 ";
            Gentoo = " ";
            HardenedBSD = "󰞌 ";
            Illumos = "󰈸 ";
            Kali = " ";
            Linux = " ";
            Mabox = " ";
            Macos = " ";
            Manjaro = " ";
            Mariner = " ";
            MidnightBSD = " ";
            Mint = " ";
            NetBSD = " ";
            NixOS = " ";
            Nobara = " ";
            OpenBSD = "󰈺 ";
            OracleLinux = "󰌷 ";
            Pop = " ";
            Raspbian = " ";
            RedHatEnterprise = " ";
            Redhat = " ";
            Redox = "󰀘 ";
            RockyLinux = " ";
            SUSE = " ";
            Solus = "󰠳 ";
            Ubuntu = " ";
            Unknown = " ";
            Void = " ";
            Windows = "󰍲 ";
            openSUSE = " ";
          };
        };
        username = {
          format = "[$user@]($style)";
          show_always = true;
          style_root = "bold yellow";
          style_user = "bold green";
        };
        sudo = {
          disabled = false;
          style = "bold yellow";
          symbol = " ";
        };
        directory = {
          read_only = " 󰌾";
          style = "bold green";
          truncation_length = 0;
          truncation_symbol = "../";
        };
        aws = {
          style = "blue";
          symbol = "  ";
        };
        buf = {symbol = " ";};
        c = {
          style = "blue";
          symbol = " ";
        };
        cmake = {
          style = "blue";
          symbol = " ";
        };
        conda = {
          style = "green";
          symbol = " ";
        };
        crystal = {
          style = "black";
          symbol = " ";
        };
        dart = {
          style = "blue";
          symbol = " ";
        };
        docker_context = {
          style = "blue";
          symbol = " ";
        };
        elixir = {
          style = "purple";
          symbol = " ";
        };
        elm = {
          style = "yellow";
          symbol = " ";
        };
        fennel = {
          style = "white";
          symbol = " ";
        };
        fossil_branch = {
          style = "bold blue";
          symbol = " ";
        };
        git_branch = {
          style = "bold red";
          symbol = " ";
        };
        git_commit = {
          style = "bold red";
          tag_symbol = "  ";
        };
        git_status = {style = "bold red";};
        golang = {
          style = "blue";
          symbol = " ";
        };
        gradle = {
          style = "blue";
          symbol = " ";
        };
        guix_shell = {
          style = "yellow";
          symbol = " ";
        };
        haskell = {
          style = "purple";
          symbol = " ";
        };
        haxe = {
          style = "yellow";
          symbol = " ";
        };
        hg_branch = {
          style = "blue";
          symbol = " ";
        };
        hostname = {
          format = "[$ssh_symbol$hostname:]($style) ";
          ssh_only = false;
          ssh_symbol = " ";
          style = "bold purple";
        };
        java = {
          style = "yellow";
          symbol = " ";
        };
        julia = {
          style = "purple";
          symbol = " ";
        };
        kotlin = {
          style = "purple";
          symbol = " ";
        };
        lua = {
          style = "blue";
          symbol = " ";
        };
        memory_usage = {
          style = "blue";
          symbol = "󰍛 ";
        };
        meson = {
          style = "blue";
          symbol = "󰔷 ";
        };
        nim = {
          style = "yellow";
          symbol = "󰆥 ";
        };
        nix_shell = {
          style = "blue";
          symbol = " ";
        };
        nodejs = {
          style = "green";
          symbol = " ";
        };
        ocaml = {
          style = "yellow";
          symbol = " ";
        };
        package = {
          style = "red";
          symbol = "󰏗 ";
        };
        perl = {
          style = "blue";
          symbol = " ";
        };
        php = {
          style = "purple";
          symbol = " ";
        };
        pijul_channel = {symbol = " ";};
        python = {
          style = "green";
          symbol = " ";
        };
        rlang = {
          style = "blue";
          symbol = "󰟔 ";
        };
        ruby = {
          style = "red";
          symbol = " ";
        };
        rust = {
          style = "red";
          symbol = "󱘗 ";
        };
        scala = {
          style = "red";
          symbol = " ";
        };
        swift = {
          style = "red";
          symbol = " ";
        };
        zig = {
          style = "yellow";
          symbol = " ";
        };
      };
    };
  };
}
