require("cmp_path")
require("cmp_nvim_lsp")

local cmp = require("cmp")
cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
    })
})
