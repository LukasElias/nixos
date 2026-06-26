{...}: {
  time.timeZone = "Europe/Copenhagen";

  i18n.defaultLocale = "da_DK.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "dk";
    useXkbConfig = true; # use xkb.options in tty.
  };
}
