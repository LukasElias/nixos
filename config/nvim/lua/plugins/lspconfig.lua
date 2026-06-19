local servers = {
    "rust_analyzer",
    "lua_ls",
}

local on_attach = function(_, bufnr)
    local bufmap = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
    end

    bufmap("<leader>r", vim.lsp.buf.rename, "Rename")

    bufmap("gd", vim.lsp.buf.definition, "Go to definition")
    bufmap("gD", vim.lsp.buf.declaration, "Go to declaration")
    bufmap("gI", vim.lsp.buf.implementation, "Go to implementation")
    bufmap("<leader>D", vim.lsp.buf.type_definition, "Go to type_defintion")

    -- bufmap("gr", require("telescope.builtin").lsp_references)
    -- bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols)
    -- bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols)

    bufmap("K", vim.lsp.buf.hover, "Hover")
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, server in ipairs(servers) do
    vim.lsp.config(server, {
        capabilities = capabilities,
		on_attach = on_attach,
    })
    vim.lsp.enable(server)
end
