{
  config,
  lib,
  ...
}: {
  options.myHomeManager.programs.graphical.hyprlock = {
    enable = lib.mkEnableOption "hyprlock";
  };

  config = lib.mkIf config.myHomeManager.programs.graphical.hyprlock.enable {
    programs.hyprlock = {
      enable = true;

      settings = {
        "$accentColor" = config.colorScheme.palette.base0E;
        "$textColor" = config.colorScheme.palette.base05;
        "$baseColor" = config.colorScheme.palette.base00;
        "$surfaceColor" = config.colorScheme.palette.base02;
        "$redColor" = config.colorScheme.palette.base08;
        "$yellowColor" = config.colorScheme.palette.base0A;
        "$font" = config.myHomeManager.theme.font.defaultFonts.monospace.family;

        general = {
          hide_cursor = true;
          ignore_empty_input = true;
        };

        background = {
          path = "screenshot";
          blur_passes = 3;
          color = "rgba($baseColorbb)";
        };

        label = [
          # time
          {
            text = "$TIME";
            color = "rgb($textColor)";
            font_size = 90;
            font_family = "$font";
            position = "0, -50";
            halign = "center";
            valign = "top";
          }
          # username
          {
            text = "$USER";
            color = "rgb($textColor)";
            font_size = 25;
            font_family = "$font";
            position = "0, -200";
            halign = "center";
            valign = "top";
          }
        ];

        input-field = {
          size = "300, 60";
          outline_thickness = 4;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgb($accentColor)";
          inner_color = "rgb($surfaceColor)";
          font_color = "rgb($textColor)";
          fade_on_empty = false;
          placeholder_text = "<span foreground=\"##$textColor\"><i>󰌾 Logged in as </i><span foreground=\"##$accentColor\">$USER</span></span>";
          hide_input = false;
          check_color = "rgb($accentColor)";
          fail_color = "rgb($redColor)";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          capslock_color = "rgb($yellowColor)";
          position = "0, 0";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
