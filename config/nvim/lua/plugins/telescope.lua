require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

require("telescope").load_extension("fzf")

-- files
vim.keymap.set("n", "<leader>sl", require("telescope.builtin").live_grep, { desc = "[s]earch [l]ive grep" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").git_files, { desc = "[s]earch [g]it files" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[s]earch [f]iles" })

-- vim
vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[s]earch [b]uffers" })
vim.keymap.set("n", "<leader>sm", require("telescope.builtin").man_pages, { desc = "[s]earch [m]an pages" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").command_history, { desc = "[s]earch command [h]istory" })

-- telescope
vim.keymap.set("n", "<leader>st", require("telescope.builtin").builtin, { desc = "[s]earch [t]elescope builtin" })
