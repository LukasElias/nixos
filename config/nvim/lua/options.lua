vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.mouse = 'a'

vim.opt.clipboard = 'unnamedplus'

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.wo.signcolumn = 'yes'

vim.opt.updatetime = 350
vim.opt.timeoutlen = 300

vim.opt.linebreak = true

vim.opt.completeopt = {
    'menuone',
    'noinsert',
    'noselect'
}

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
