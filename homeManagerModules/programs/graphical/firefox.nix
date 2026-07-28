{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.myHomeManager.programs.graphical.firefox = {
    enable = lib.mkEnableOption "firefox";
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.firefox.enable {
    programs.firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
      languagePacks = [
        "en-GB"
        "da"
      ];
      profiles."${config.home.username}" = {
        name = "${config.home.username}";
        isDefault = true;

        search = {
          force = true;
          default = "ddg";
          engines = {
            google.metaData.alias = "@g";

            nix-packages = {
              name = "Nix Packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            nixos-options = {
              name = "Nix Options";
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };

            home-manager-options = {
              name = "Home Manager Options";
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
                    }
                    {
                      name = "source";
                      value = "home_manager";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@ho"];
            };
          };
        };

        settings = {
          "browser.startup.page" = 3;
          "browser.smartwindow.sidebar.openByDefault" = false;
          "browser.newtabpage.activity-stream.widgets.weather.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.toolbars.bookmarks.visibility" = "never";
          "sidebar.main.tools" = "history,bookmarks";
          "sidebar.verticalTabs" = true;
          "sidebar.revamp" = true;
          "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
        };

        extensions = {
          force = true;
          packages = with inputs.firefox-addons.packages."${pkgs.stdenv.hostPlatform.system}"; [
            ublock-origin
            keepassxc-browser
            vimium
          ];
        };
      };
    };
  };
}
