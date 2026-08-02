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
          "browser.uiCustomization.state" = lib.toJSON {
            "placements" = {
              "widget-overflow-fixed-list" = [
                "print-button"
                "preferences-button"
                "screenshot-button"
              ];
              "unified-extensions-area" = [
                "ublock0_raymondhill_net-browser-action"
                "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
                "keepassxc-browser_keepassxc_org-browser-action"
              ];
              "nav-bar" = [
                "reset-pbm-toolbar-button"
                "sidebar-button"
                "home-button"
                "stop-reload-button"
                "back-button"
                "forward-button"
                "urlbar-container"
                "unified-extensions-button"
                "developer-button"
                "downloads-button"
                "vertical-spacer"
              ];
              "toolbar-menubar" = [
                "menubar-items"
              ];
              "TabsToolbar" = [];
              "vertical-tabs" = [
                "tabbrowser-tabs"
              ];
              "PersonalToolbar" = [
                "import-button"
                "personal-bookmarks"
              ];
            };
            "seen" = [
              "reset-pbm-toolbar-button"
              "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
              "keepassxc-browser_keepassxc_org-browser-action"
              "ublock0_raymondhill_net-browser-action"
              "developer-button"
              "screenshot-button"
            ];
            "dirtyAreaCache" = [
              "unified-extensions-area"
              "nav-bar"
              "TabsToolbar"
              "vertical-tabs"
              "PersonalToolbar"
              "toolbar-menubar"
              "widget-overflow-fixed-list"
            ];
            "currentVersion" = 24;
            "newElementCount" = 1;
          };
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
