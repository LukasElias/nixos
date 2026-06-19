local servers = {
    "rust_analyzer",
    "lua_ls",
}

local on_attach = function(_, bufnr)
    
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for _, server in ipairs(servers) do
    vim.lsp.config(server, {
        capabilities = capabilities,
    })
    vim.lsp.enable(server)
end
