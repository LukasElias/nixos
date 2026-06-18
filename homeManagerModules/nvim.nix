{ config, lib, pkgs, ... }:

{
  xdg.configFile."nvim" = {
    source = ../config/nvim;
    recursive = true;
  };

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
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

      # other
      indent-blankline-nvim
      lualine-nvim
      nvim-tree-lua
      nvim-web-devicons
      telescope-nvim
      plenary-nvim
      which-key-nvim
      comment-nvim
    ];

    extraPackages = with pkgs; [
      wl-clipboard
      fd
      ripgrep
    ];

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    waylandSupport = true;
  };
}
