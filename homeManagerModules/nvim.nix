{ config, lib, pkgs, ... }:

{
  xdg.configFile."nvim" = {
    source = ../config/nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      # colorscheme
      catppuccin-nvim

      # languages
      nvim-lspconfig
      nvim-treesitter.withAllGrammars

      # nvim-cmp
      nvim-cmp
      cmp-nvim-lsp
      cmp-path

      # git
      gitsigns-nvim
      vim-fugitive
      vim-rhubarb

      # telescope
      telescope-fzf-native-nvim
      telescope-nvim
      plenary-nvim

      # other
      indent-blankline-nvim
      lualine-nvim
      nvim-tree-lua
      nvim-web-devicons
      which-key-nvim
      comment-nvim
	  lazydev-nvim
    ];

    extraPackages = with pkgs; [
      wl-clipboard
      fd
      ripgrep
      rust-analyzer
      lua-language-server
	  nil
    ];

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    waylandSupport = true;

    withPerl = false;
    withRuby = false;
    withNodeJs = false;
    withPython3 = false;
  };
}
