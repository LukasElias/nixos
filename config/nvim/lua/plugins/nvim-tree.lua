require("nvim-tree").setup({
    disable_netrw = true,
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>", { desc = "[n]vim-tree [t]oggle" })
