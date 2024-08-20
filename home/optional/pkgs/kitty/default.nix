{ ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode";
      size = 12.0;
    };
    settings = {
      shell = "tmux";
      window_padding_width = 4;
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
    extraConfig = builtins.readFile ./config.conf;
  };
}
