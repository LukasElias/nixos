vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 350
vim.opt.timeoutlen = 300

vim.opt.linebreak = true

vim.opt.completeopt = {
    "menuone",
    "noinsert",
    "noselect"
}

vim.opt.list = true
vim.opt.listchars = {
    space = "⋅",
    tab = "» ",
    trail = "•",
}

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- Keybinds

vim.keymap.set("n", "H", function()
    vim.opt.hlsearch = not vim.opt.hlsearch:get()
end)

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps

vim.diagnostic.config({
    jump = {
        on_jump = function(_, bufnr)
            vim.diagnostic.open_float({ bufnr = bufnr })
        end
    }
})

vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Go to next diagnostic message" })
