{ config, lib, pkgs, ... }:

let
  nvimConfig = pkgs.vimUtils.buildVimPlugin {
    name = "nvimConfig";
    src = ../config/nvim;
  };
in 
{
  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      # theme
      catppuccin-nvim

      # languages
      nvim-lspconfig
      nvim-treesitter.withAllGrammers

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

      # my config
      nvimConfig
    ];

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  }
}
